/**
 * audit-variables.js
 *
 * Scans all .ink files under prototype/ink/ and audits VAR declarations.
 * For each variable, determines whether it is:
 *   - HEALTHY: read and written (outside its VAR declaration)
 *   - WRITE-ONLY: written but never read
 *   - READ-ONLY: read but never written (outside VAR declaration)
 *   - ORPHANED: never read or written (outside VAR declaration)
 *
 * Usage: node scripts/audit-variables.js
 * Exit code 0 normally, exit code 1 if more than 10 orphaned vars.
 */

const fs = require('fs');
const path = require('path');

// ── Helpers ──────────────────────────────────────────────────────────

/**
 * Recursively collect all .ink files under a directory.
 */
function collectInkFiles(dir) {
  let results = [];
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      results = results.concat(collectInkFiles(full));
    } else if (entry.isFile() && entry.name.endsWith('.ink')) {
      results.push(full);
    }
  }
  return results;
}

/**
 * Return true if a line is a comment (trimmed starts with //).
 */
function isComment(line) {
  return /^\s*\/\//.test(line);
}

// ── Main logic ───────────────────────────────────────────────────────

const inkDir = path.resolve(__dirname, '..', 'ink');
const files = collectInkFiles(inkDir);

// 1. Extract all VAR declarations ────────────────────────────────────

const varDeclRe = /^VAR\s+(\w+)\s*=/;

/** Map: varName -> { file, line } */
const declarations = new Map();

for (const filePath of files) {
  const lines = fs.readFileSync(filePath, 'utf-8').split(/\r?\n/);
  for (let i = 0; i < lines.length; i++) {
    const line = lines[i];
    if (isComment(line)) continue;
    const m = line.match(varDeclRe);
    if (m) {
      const varName = m[1];
      declarations.set(varName, {
        file: path.relative(path.resolve(__dirname, '..'), filePath).replace(/\\/g, '/'),
        line: i + 1,
      });
    }
  }
}

// 2. For each variable, search for writes and reads ──────────────────

/**
 * A WRITE is a line matching:
 *   ~ varname =   (but NOT the VAR declaration line)
 *   ~ varname +=
 *   ~ varname -=
 *
 * We also need to avoid matching inside longer identifiers, so we use
 * word-boundary matching.
 */

/**
 * A READ is any other occurrence of the variable name as a whole word,
 * excluding VAR declaration lines and write lines for this variable.
 */

/** Map: varName -> { writes: [{file,line}], reads: [{file,line}] } */
const usage = new Map();
for (const varName of declarations.keys()) {
  usage.set(varName, { writes: [], reads: [] });
}

for (const filePath of files) {
  const relPath = path.relative(path.resolve(__dirname, '..'), filePath).replace(/\\/g, '/');
  const lines = fs.readFileSync(filePath, 'utf-8').split(/\r?\n/);

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i];
    if (isComment(line)) continue;

    // Skip VAR declaration lines entirely for usage detection
    if (varDeclRe.test(line)) continue;

    for (const varName of declarations.keys()) {
      // Check if varName appears as a whole word in this line
      const wordRe = new RegExp('\\b' + varName + '\\b');
      if (!wordRe.test(line)) continue;

      // Check if this is a write
      // Patterns: ~ varname = ..., ~ varname += ..., ~ varname -= ...
      const writeRe = new RegExp(
        '~\\s*' + varName + '\\s*([+\\-]?=)'
      );
      const isWrite = writeRe.test(line);

      if (isWrite) {
        usage.get(varName).writes.push({ file: relPath, line: i + 1 });
      }

      // Check if there's also a read on this line (the variable may appear
      // in both a write target AND in the expression, e.g. ~ x = x + 1)
      // For simplicity, if it appears as a word and it's NOT purely a write
      // target, count it as a read too.
      // We count a read if:
      //   - The line is NOT a write for this var, OR
      //   - The var appears more than once on the line (e.g., ~ x = x + 1)
      const allOccurrences = line.match(new RegExp('\\b' + varName + '\\b', 'g'));
      const occurrenceCount = allOccurrences ? allOccurrences.length : 0;

      if (!isWrite) {
        // Pure read line
        usage.get(varName).reads.push({ file: relPath, line: i + 1 });
      } else if (occurrenceCount > 1) {
        // Write line but var also appears on the right side (self-reference)
        usage.get(varName).reads.push({ file: relPath, line: i + 1 });
      }
    }
  }
}

// 3. Categorize ──────────────────────────────────────────────────────

const categories = {
  HEALTHY: [],
  WRITE_ONLY: [],
  READ_ONLY: [],
  ORPHANED: [],
};

for (const [varName, decl] of declarations) {
  const u = usage.get(varName);
  const hasWrites = u.writes.length > 0;
  const hasReads = u.reads.length > 0;

  if (hasWrites && hasReads) {
    categories.HEALTHY.push({ varName, decl, usage: u });
  } else if (hasWrites && !hasReads) {
    categories.WRITE_ONLY.push({ varName, decl, usage: u });
  } else if (!hasWrites && hasReads) {
    categories.READ_ONLY.push({ varName, decl, usage: u });
  } else {
    categories.ORPHANED.push({ varName, decl, usage: u });
  }
}

// 4. Print report ────────────────────────────────────────────────────

function printCategory(label, items, showDetail) {
  console.log(`\n${'='.repeat(60)}`);
  console.log(`  ${label} (${items.length})`);
  console.log('='.repeat(60));
  if (items.length === 0) {
    console.log('  (none)');
    return;
  }
  for (const item of items) {
    console.log(`  ${item.varName}`);
    console.log(`    Declared: ${item.decl.file}:${item.decl.line}`);
    if (showDetail) {
      if (item.usage.writes.length > 0) {
        console.log(`    Writes:`);
        for (const w of item.usage.writes) {
          console.log(`      ${w.file}:${w.line}`);
        }
      }
      if (item.usage.reads.length > 0) {
        console.log(`    Reads:`);
        for (const r of item.usage.reads) {
          console.log(`      ${r.file}:${r.line}`);
        }
      }
    }
  }
}

const total = declarations.size;
console.log(`\n  VARIABLE AUDIT REPORT`);
console.log(`  Total VAR declarations found: ${total}`);
console.log(`  Files scanned: ${files.length}`);

printCategory('HEALTHY (read + written)', categories.HEALTHY, false);
printCategory('WRITE-ONLY (written but never read)', categories.WRITE_ONLY, true);
printCategory('READ-ONLY (read but never written outside VAR)', categories.READ_ONLY, true);
printCategory('ORPHANED (never read or written outside VAR)', categories.ORPHANED, true);

// Summary
console.log(`\n${'='.repeat(60)}`);
console.log(`  SUMMARY`);
console.log('='.repeat(60));
console.log(`  HEALTHY:    ${categories.HEALTHY.length}`);
console.log(`  WRITE-ONLY: ${categories.WRITE_ONLY.length}`);
console.log(`  READ-ONLY:  ${categories.READ_ONLY.length}`);
console.log(`  ORPHANED:   ${categories.ORPHANED.length}`);
console.log(`  TOTAL:      ${total}`);
console.log('');

// 5. Exit code ───────────────────────────────────────────────────────

if (categories.ORPHANED.length > 10) {
  console.log(`!! WARNING: ${categories.ORPHANED.length} orphaned variables (threshold: 10). Exiting with code 1.`);
  process.exit(1);
} else {
  console.log(`OK: ${categories.ORPHANED.length} orphaned variables (threshold: 10).`);
  process.exit(0);
}
