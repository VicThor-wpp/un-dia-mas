const fs = require('fs');
const path = require('path');

const ROOT = path.resolve(__dirname, '..');
const INK_DIR = path.join(ROOT, 'ink');
const ENTRY_FILE = 'main.ink';
const OUTPUT_FILE_FULL = path.join(ROOT, 'GUION_COMPLETO.md');
const OUTPUT_FILE_CLEAN = path.join(ROOT, 'GUION_LECTURA.md');

// Files to exclude in clean mode
const EXCLUDED_DIRS = ['mecanicas', 'variables.ink'];

function cleanInkLine(line) {
    let text = line.trim();

    // Skip logical lines
    if (text.startsWith('VAR ')) return null;
    if (text.startsWith('CONST ')) return null;
    if (text.startsWith('EXTERNAL ')) return null;
    if (text.startsWith('~')) return null;
    if (text.startsWith('//')) return null;
    if (text.startsWith('INCLUDE ')) return null;
    if (text.startsWith('->')) return null; // Diverts often distract in reading
    if (text === 'TODO') return null;

    // Format headers (Knots)
    if (text.startsWith('===')) {
        // "=== name ===" -> "## name"
        let name = text.replace(/===/g, '').trim();
        // Remove parameters if any "name(param)"
        if (name.includes('(')) name = name.split('(')[0];

        // Skip function definitions in clean mode
        if (text.includes('function')) return null;

        return `\n## ${name.toUpperCase()}\n`;
    }

    // Format sub-headers (Stitches)
    if (text.startsWith('= ')) {
        let name = text.replace('=', '').trim();
        return `\n### ${name}\n`;
    }

    // Format choices
    if (text.startsWith('*') || text.startsWith('+')) {
        // "* [Opción]" or "* Opción"
        let choice = text.replace(/^[\*\+]+/, '').trim();

        // Handle brackets "* [Text] logica" -> "- Text"
        if (choice.startsWith('[')) {
            const closingBracket = choice.indexOf(']');
            if (closingBracket > -1) {
                choice = choice.substring(1, closingBracket);
            }
        }

        return `- **OPCIÓN:** ${choice}`;
    }

    // Conditional text "{logic: text}" -> simplificar?
    // For now, keep it simple, maybe strip brackets if simple
    if (text.startsWith('{') && !text.includes(':')) {
        // Simple variable print {name} -> name (keep as is or strip?)
        // Let's leave it for now, usually rare in pure text lines
    }

    // Remove tags # TAG
    if (text.includes('#')) {
        text = text.split('#')[0].trim();
    }

    if (text.length === 0) return ''; // Preserve empty lines for spacing

    return text;
}

function processFile(filePath, mode = 'full', depth = 0) {
    const fullPath = path.join(INK_DIR, filePath);

    if (!fs.existsSync(fullPath)) {
        return `> [ERROR: File not found: ${filePath}]\n`;
    }

    // Clean mode exclusion
    if (mode === 'clean') {
        // normalize path separator for checking
        const normPath = filePath.replace(/\\/g, '/');
        if (EXCLUDED_DIRS.some(ex => normPath.includes(ex))) {
            return '';
        }
    }

    const content = fs.readFileSync(fullPath, 'utf8');
    const lines = content.split('\n');
    let output = '';

    // Header only for full mode or major files in clean mode
    if (mode === 'full') {
        output += `\n${'#'.repeat(depth + 1)} FILE: ${filePath}\n\n`;
    }

    for (const line of lines) {
        const trimmed = line.trim();

        // Handle INCLUDES recursion
        if (trimmed.startsWith('INCLUDE ')) {
            const includedKey = trimmed.replace('INCLUDE ', '').trim();
            output += processFile(includedKey, mode, depth + 1);
            continue;
        }

        if (mode === 'clean') {
            const cleaned = cleanInkLine(line);
            if (cleaned !== null) {
                output += cleaned + '\n';
            }
        } else {
            // Full mode: raw line
            output += line + '\n';
        }
    }

    return output;
}

console.log('Generating scripts...');

// 1. Generate FULL (Technical)
console.log('1. Generating FULL Manuscript (Technical)...');
const fullContent = `# UN DÍA MÁS - GUIÓN TÉCNICO COMPLETO
Generated: ${new Date().toLocaleString()}
Contains all logic, variables, and system files.
\n` + processFile(ENTRY_FILE, 'full');
fs.writeFileSync(OUTPUT_FILE_FULL, fullContent, 'utf8');

// 2. Generate CLEAN (Readable)
console.log('2. Generating CLEAN Manuscript (Readable)...');
const cleanContent = `# UN DÍA MÁS - GUIÓN DE LECTURA
Generated: ${new Date().toLocaleString()}
Simplified for reading. No logic, no system files.
\n` + processFile(ENTRY_FILE, 'clean');
fs.writeFileSync(OUTPUT_FILE_CLEAN, cleanContent, 'utf8');

console.log('Done!');
console.log(`- Technical: ${OUTPUT_FILE_FULL}`);
console.log(`- Readable:  ${OUTPUT_FILE_CLEAN}`);
