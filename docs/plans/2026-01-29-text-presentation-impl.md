# Text Presentation System - Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Implement fade-in paragraph animations, dramatic pauses with click-to-continue, and optional typewriter effect.

**Architecture:** New `TextPresenter` module intercepts text before DOM rendering, queues paragraphs, applies fade-in with configurable timing, detects pause conditions (tags + heuristics), shows continue indicator.

**Tech Stack:** Vanilla JS, CSS transitions, no dependencies.

---

## Task 1: Create TextPresenter Module Structure

**Files:**
- Create: `prototype/web/modules/text-presenter.js`

**Step 1: Create the module skeleton**

```javascript
/**
 * TextPresenter - Handles paragraph animations and dramatic pauses
 */
const TextPresenter = (function() {
    'use strict';

    // Configuration
    const CONFIG = {
        fadeInDuration: 450,      // ms
        delayBetweenParagraphs: 300, // ms
        typewriterBaseSpeed: 30,  // ms per character
        pausePatterns: {
            shortLine: 15,        // chars - lines <= this trigger pause
            ellipsis: '...',
            sceneChange: '==='
        }
    };

    // State
    let paragraphQueue = [];
    let isPresenting = false;
    let isPaused = false;
    let onComplete = null;
    let currentContainer = null;

    /**
     * Initialize the presenter
     */
    function init() {
        // Will be called by GameEngine
    }

    /**
     * Present content with animations
     * @param {HTMLElement} container - Target container
     * @param {Array} items - Content items to present
     * @param {Function} callback - Called when all content is shown
     */
    function present(container, items, callback) {
        currentContainer = container;
        paragraphQueue = [...items];
        onComplete = callback;
        isPresenting = true;
        isPaused = false;

        showNext();
    }

    /**
     * Show next item in queue
     */
    function showNext() {
        // Implementation in next task
    }

    /**
     * Check if should pause after this content
     * @param {object} item - Content item
     * @param {Array} tags - Associated tags
     * @returns {boolean}
     */
    function shouldPause(item, tags) {
        return false; // Implementation in Task 3
    }

    /**
     * Show pause indicator and wait for input
     */
    function showPauseIndicator() {
        // Implementation in Task 4
    }

    /**
     * Continue after pause
     */
    function continue_() {
        if (!isPaused) return;
        isPaused = false;
        hidePauseIndicator();
        showNext();
    }

    /**
     * Hide pause indicator
     */
    function hidePauseIndicator() {
        const indicator = document.querySelector('.pause-indicator');
        if (indicator) indicator.remove();
    }

    /**
     * Skip all animations (accessibility)
     */
    function skipAll() {
        if (!isPresenting) return;

        // Show all remaining content immediately
        for (const item of paragraphQueue) {
            renderItem(item, true);
        }
        paragraphQueue = [];
        isPresenting = false;
        hidePauseIndicator();

        if (onComplete) onComplete();
    }

    /**
     * Render a single item
     * @param {object} item - Content item
     * @param {boolean} instant - Skip animation
     */
    function renderItem(item, instant = false) {
        // Implementation in Task 2
    }

    /**
     * Check if currently presenting
     */
    function isBusy() {
        return isPresenting;
    }

    // Public API
    return {
        init,
        present,
        continue: continue_,
        skipAll,
        isBusy
    };
})();

// Expose globally
if (typeof window !== 'undefined') {
    window.TextPresenter = TextPresenter;
}
```

**Step 2: Verify file created**

Run: `ls -la prototype/web/modules/text-presenter.js`
Expected: File exists with correct size (~2KB)

**Step 3: Commit**

```bash
git add prototype/web/modules/text-presenter.js
git commit -m "feat(text-presenter): create module skeleton"
```

---

## Task 2: Implement Fade-In Rendering

**Files:**
- Modify: `prototype/web/modules/text-presenter.js`
- Modify: `prototype/web/style.css`

**Step 1: Add CSS for fade-in paragraphs**

In `prototype/web/style.css`, find the `@keyframes fadeIn` section (around line 399) and add after it:

```css
/* ==========================================
   TEXT PRESENTER - Animated Paragraphs
   ========================================== */

.tp-paragraph {
    opacity: 0;
    transform: translateY(8px);
}

.tp-paragraph.tp-visible {
    opacity: 1;
    transform: translateY(0);
    transition: opacity 450ms ease-out, transform 450ms ease-out;
}

.tp-paragraph.tp-instant {
    opacity: 1;
    transform: translateY(0);
    transition: none;
}

/* Respect reduced motion preference */
@media (prefers-reduced-motion: reduce) {
    .tp-paragraph {
        opacity: 1;
        transform: none;
        transition: none;
    }
    .tp-paragraph.tp-visible {
        transition: none;
    }
}
```

**Step 2: Implement renderItem and showNext in text-presenter.js**

Replace the `renderItem` function:

```javascript
    /**
     * Render a single item
     * @param {object} item - Content item
     * @param {boolean} instant - Skip animation
     */
    function renderItem(item, instant = false) {
        const el = document.createElement(item.type === 'header' ? 'h1' : 'div');

        switch (item.type) {
            case 'header':
                el.textContent = item.content;
                el.className = 'story-header tp-paragraph';
                break;
            case 'text':
                el.innerHTML = item.content;
                el.className = 'story-text tp-paragraph';
                break;
            case 'idea':
                el.textContent = item.content;
                el.className = 'tag-idea tp-paragraph';
                break;
            case 'fragmento':
                el.textContent = item.content;
                el.className = 'tag-fragmento tp-paragraph';
                break;
            default:
                el.innerHTML = item.content || '';
                el.className = 'tp-paragraph';
        }

        currentContainer.appendChild(el);

        if (instant || prefersReducedMotion()) {
            el.classList.add('tp-instant');
        } else {
            // Trigger reflow, then add visible class
            el.offsetHeight;
            requestAnimationFrame(() => {
                el.classList.add('tp-visible');
            });
        }

        return el;
    }

    /**
     * Check for reduced motion preference
     */
    function prefersReducedMotion() {
        return window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    }
```

Replace the `showNext` function:

```javascript
    /**
     * Show next item in queue
     */
    function showNext() {
        if (paragraphQueue.length === 0) {
            isPresenting = false;
            if (onComplete) onComplete();
            return;
        }

        const item = paragraphQueue.shift();
        const tags = item.tags || [];

        renderItem(item);

        // Check if we should pause
        if (shouldPause(item, tags)) {
            isPaused = true;
            setTimeout(() => {
                showPauseIndicator();
            }, CONFIG.fadeInDuration);
            return;
        }

        // Continue to next after delay
        if (paragraphQueue.length > 0) {
            setTimeout(showNext, CONFIG.delayBetweenParagraphs);
        } else {
            setTimeout(() => {
                isPresenting = false;
                if (onComplete) onComplete();
            }, CONFIG.fadeInDuration);
        }
    }
```

**Step 3: Test CSS is valid**

Run: `head -20 prototype/web/style.css && echo "..." && grep -A5 "tp-paragraph" prototype/web/style.css`
Expected: CSS syntax looks correct, no obvious errors

**Step 4: Commit**

```bash
git add prototype/web/modules/text-presenter.js prototype/web/style.css
git commit -m "feat(text-presenter): implement fade-in paragraph rendering"
```

---

## Task 3: Implement Pause Detection (Heuristics + Tags)

**Files:**
- Modify: `prototype/web/modules/text-presenter.js`

**Step 1: Implement shouldPause function**

Replace the `shouldPause` function:

```javascript
    /**
     * Check if should pause after this content
     * @param {object} item - Content item
     * @param {Array} tags - Associated tags
     * @returns {boolean}
     */
    function shouldPause(item, tags) {
        // Never pause on headers
        if (item.type === 'header') return false;

        // Check for explicit CONTINUO tag (override - never pause)
        if (tags.includes('CONTINUO')) return false;

        // Check for explicit PAUSA tag
        if (tags.includes('PAUSA')) return true;

        // Only apply heuristics to text content
        if (item.type !== 'text') return false;

        const text = item.content || '';
        const strippedText = text.replace(/<[^>]*>/g, '').trim();

        // Heuristic 1: Short lines alone (dramatic impact)
        if (strippedText.length > 0 && strippedText.length <= CONFIG.pausePatterns.shortLine) {
            // Only if it's not a question or continues a sentence
            if (!strippedText.endsWith('?') && !strippedText.startsWith(',')) {
                return true;
            }
        }

        // Heuristic 2: Ends with ellipsis (suspense)
        if (strippedText.endsWith(CONFIG.pausePatterns.ellipsis)) {
            return true;
        }

        return false;
    }
```

**Step 2: Add PAUSA and CONTINUO to tag processing**

Add this function to handle tag extraction from Ink:

```javascript
    /**
     * Extract presentation tags from Ink tags array
     * @param {Array} allTags - All tags from Ink
     * @returns {Array} Presentation-relevant tags
     */
    function extractPresentationTags(allTags) {
        if (!allTags) return [];
        return allTags.filter(tag =>
            tag === 'PAUSA' ||
            tag === 'CONTINUO' ||
            tag.startsWith('PAUSA:') ||
            tag.startsWith('CONTINUO:')
        );
    }
```

Add to public API:
```javascript
    return {
        init,
        present,
        continue: continue_,
        skipAll,
        isBusy,
        extractPresentationTags
    };
```

**Step 3: Commit**

```bash
git add prototype/web/modules/text-presenter.js
git commit -m "feat(text-presenter): implement pause detection with heuristics and tags"
```

---

## Task 4: Implement Pause Indicator

**Files:**
- Modify: `prototype/web/modules/text-presenter.js`
- Modify: `prototype/web/style.css`

**Step 1: Add CSS for pause indicator**

In `prototype/web/style.css`, add after the tp-paragraph styles:

```css
/* Pause indicator */
.pause-indicator {
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 20px;
    opacity: 0.6;
    animation: tp-pulse 1.5s ease-in-out infinite;
    cursor: pointer;
    user-select: none;
}

.pause-indicator-symbol {
    font-size: 1.2em;
    color: var(--accent);
}

@keyframes tp-pulse {
    0%, 100% { opacity: 0.4; }
    50% { opacity: 0.9; }
}

/* Click anywhere hint on mobile */
@media (pointer: coarse) {
    .pause-indicator::after {
        content: 'toca para continuar';
        font-size: 0.75em;
        opacity: 0.5;
        margin-left: 10px;
    }
}

@media (prefers-reduced-motion: reduce) {
    .pause-indicator {
        animation: none;
        opacity: 0.7;
    }
}
```

**Step 2: Implement showPauseIndicator in text-presenter.js**

Replace the `showPauseIndicator` function:

```javascript
    /**
     * Show pause indicator and wait for input
     */
    function showPauseIndicator() {
        // Remove any existing indicator
        hidePauseIndicator();

        const indicator = document.createElement('div');
        indicator.className = 'pause-indicator';
        indicator.innerHTML = '<span class="pause-indicator-symbol">▼</span>';
        indicator.setAttribute('role', 'button');
        indicator.setAttribute('aria-label', 'Continuar leyendo');
        indicator.setAttribute('tabindex', '0');

        // Click to continue
        indicator.addEventListener('click', handleContinueInput);
        indicator.addEventListener('keydown', (e) => {
            if (e.key === 'Enter' || e.key === ' ') {
                e.preventDefault();
                handleContinueInput();
            }
        });

        currentContainer.appendChild(indicator);

        // Also listen for clicks anywhere (with debounce)
        setTimeout(() => {
            document.addEventListener('click', handleDocumentClick);
            document.addEventListener('keydown', handleKeyPress);
        }, 100);

        // Scroll indicator into view
        indicator.scrollIntoView({ behavior: 'smooth', block: 'center' });
    }

    /**
     * Handle continue input
     */
    function handleContinueInput() {
        if (!isPaused) return;

        // Remove listeners
        document.removeEventListener('click', handleDocumentClick);
        document.removeEventListener('keydown', handleKeyPress);

        continue_();
    }

    /**
     * Handle document click during pause
     */
    function handleDocumentClick(e) {
        // Ignore clicks on interactive elements
        if (e.target.closest('button, a, input, .modal-overlay')) return;
        handleContinueInput();
    }

    /**
     * Handle key press during pause
     */
    function handleKeyPress(e) {
        if (e.key === 'Enter' || e.key === ' ') {
            e.preventDefault();
            handleContinueInput();
        }
    }
```

**Step 3: Commit**

```bash
git add prototype/web/modules/text-presenter.js prototype/web/style.css
git commit -m "feat(text-presenter): implement pause indicator with click-to-continue"
```

---

## Task 5: Implement Typewriter Effect

**Files:**
- Modify: `prototype/web/modules/text-presenter.js`

**Step 1: Add typewriter rendering function**

Add these functions to text-presenter.js:

```javascript
    // Typewriter punctuation delays (ms)
    const PUNCTUATION_DELAYS = {
        ',': 100,
        '.': 200,
        '!': 150,
        '?': 150,
        ';': 120,
        ':': 100,
        '…': 400
    };

    /**
     * Check if typewriter is enabled
     */
    function isTypewriterEnabled() {
        if (typeof ReadingPreferences !== 'undefined') {
            const prefs = ReadingPreferences.getPrefs();
            return prefs.typewriter === true;
        }
        return false;
    }

    /**
     * Render item with typewriter effect
     * @param {object} item - Content item
     * @param {Function} callback - Called when complete
     */
    function renderTypewriter(item, callback) {
        const el = document.createElement(item.type === 'header' ? 'h1' : 'div');

        switch (item.type) {
            case 'header':
                el.className = 'story-header tp-paragraph tp-visible';
                break;
            case 'text':
                el.className = 'story-text tp-paragraph tp-visible';
                break;
            default:
                el.className = 'tp-paragraph tp-visible';
        }

        currentContainer.appendChild(el);

        const text = item.content || '';
        typewriteText(el, text, callback);
    }

    /**
     * Typewrite text into element
     * @param {HTMLElement} el - Target element
     * @param {string} text - Text to type (may contain HTML)
     * @param {Function} callback - Called when complete
     */
    function typewriteText(el, text, callback) {
        el.innerHTML = '';
        let i = 0;
        const speed = CONFIG.typewriterBaseSpeed;

        function typeChar() {
            if (i >= text.length) {
                if (callback) callback();
                return;
            }

            // Handle HTML tags - add them instantly
            if (text[i] === '<') {
                const tagEnd = text.indexOf('>', i);
                if (tagEnd !== -1) {
                    el.innerHTML += text.substring(i, tagEnd + 1);
                    i = tagEnd + 1;
                    typeChar();
                    return;
                }
            }

            // Add character
            const char = text[i];
            el.innerHTML += char;
            i++;

            // Calculate delay based on punctuation
            let delay = speed;

            // Check for ellipsis (three dots)
            if (char === '.' && text.substring(i-3, i) === '...') {
                delay = PUNCTUATION_DELAYS['…'];
            } else if (PUNCTUATION_DELAYS[char]) {
                delay = PUNCTUATION_DELAYS[char];
            }

            setTimeout(typeChar, delay);
        }

        typeChar();
    }
```

**Step 2: Update showNext to use typewriter when enabled**

Modify the `showNext` function to check for typewriter mode:

```javascript
    /**
     * Show next item in queue
     */
    function showNext() {
        if (paragraphQueue.length === 0) {
            isPresenting = false;
            if (onComplete) onComplete();
            return;
        }

        const item = paragraphQueue.shift();
        const tags = item.tags || [];

        // Check if typewriter is enabled (only for text)
        const useTypewriter = isTypewriterEnabled() &&
                             item.type === 'text' &&
                             !prefersReducedMotion();

        if (useTypewriter) {
            renderTypewriter(item, () => {
                afterRender(item, tags);
            });
        } else {
            renderItem(item);
            afterRender(item, tags);
        }
    }

    /**
     * Handle post-render logic (pause check, next item)
     */
    function afterRender(item, tags) {
        // Check if we should pause
        if (shouldPause(item, tags)) {
            isPaused = true;
            setTimeout(() => {
                showPauseIndicator();
            }, 100);
            return;
        }

        // Continue to next after delay
        if (paragraphQueue.length > 0) {
            setTimeout(showNext, CONFIG.delayBetweenParagraphs);
        } else {
            isPresenting = false;
            if (onComplete) onComplete();
        }
    }
```

**Step 3: Commit**

```bash
git add prototype/web/modules/text-presenter.js
git commit -m "feat(text-presenter): implement optional typewriter effect with variable punctuation timing"
```

---

## Task 6: Integrate with GameEngine

**Files:**
- Modify: `prototype/web/game.js`
- Modify: `prototype/web/index.html`

**Step 1: Add text-presenter.js to index.html**

In `prototype/web/index.html`, find the modules section (around line 52-66) and add text-presenter.js before game.js:

```html
    <script src="modules/text-presenter.js"></script>
```

The full modules section should look like:
```html
    <!-- Modules (order matters) -->
    <script src="modules/security-validator.js"></script>
    <script src="modules/config-manager.js"></script>
    <script src="modules/notification-system.js"></script>
    <script src="modules/decision-log.js"></script>
    <script src="modules/stats-panel.js"></script>
    <script src="modules/relationships-panel.js"></script>
    <script src="modules/portrait-system.js"></script>
    <script src="modules/save-system.js"></script>
    <script src="modules/choice-parser.js"></script>
    <script src="modules/reading-preferences.js"></script>
    <script src="modules/audio-system.js"></script>
    <script src="modules/start-screen.js"></script>
    <script src="modules/accessibility-manager.js"></script>
    <script src="modules/ending-screen.js"></script>
    <script src="modules/text-presenter.js"></script>

    <!-- Main Game Engine -->
    <script src="game.js"></script>
```

**Step 2: Modify showNextBatch in game.js to use TextPresenter**

In `prototype/web/game.js`, find the `showNextBatch` function (around line 310) and replace it:

```javascript
    /**
     * Show the next batch of content
     */
    function showNextBatch() {
        if (contentQueue.length === 0) {
            showChoices();
            return;
        }

        const batch = contentQueue.shift();

        // Check if batch starts with a header (fresh scene)
        const isNewScene = batch.length > 0 && batch[0].type === 'header';

        if (isNewScene) {
            storyContainer.innerHTML = '';
        }

        // Prepare items for TextPresenter
        const items = [];
        for (const item of batch) {
            if (item.type === 'dice') {
                // Render dice immediately (special element)
                const rollDiv = createDiceElement(item.roll, item.result, item.context);
                storyContainer.appendChild(rollDiv);
            } else {
                // Queue for animated presentation
                items.push(item);
            }
        }

        // Use TextPresenter if available, otherwise fallback to direct render
        if (typeof TextPresenter !== 'undefined' && items.length > 0) {
            TextPresenter.present(storyContainer, items, () => {
                finishBatch();
            });
        } else {
            // Fallback: render directly (old behavior)
            for (const item of items) {
                const el = document.createElement(item.type === 'header' ? 'h1' : 'div');
                switch (item.type) {
                    case 'header':
                        el.textContent = item.content;
                        el.className = 'story-header';
                        break;
                    case 'text':
                        el.innerHTML = item.content;
                        el.className = 'story-text';
                        break;
                    case 'idea':
                        el.textContent = item.content;
                        el.className = 'tag-idea';
                        break;
                    case 'fragmento':
                        el.textContent = item.content;
                        el.className = 'tag-fragmento';
                        break;
                }
                storyContainer.appendChild(el);
            }
            finishBatch();
        }

        window.scrollTo(0, 0);
    }

    /**
     * Finish batch presentation
     */
    function finishBatch() {
        // Check for changes after content
        checkStatChanges();
        saveCurrentState();
        StatsPanel.update();

        if (contentQueue.length > 0) {
            showContinueButton();
        } else {
            showChoices();
        }
    }
```

**Step 3: Initialize TextPresenter in init function**

In the `init` function (around line 36), add after other module initializations:

```javascript
        // Initialize text presenter
        if (typeof TextPresenter !== 'undefined') {
            TextPresenter.init();
        }
```

**Step 4: Test the game loads**

Run: `cd prototype/web && python3 -m http.server 8080 &`
Then open `http://localhost:8080` in browser
Expected: Game loads without JS errors in console

**Step 5: Commit**

```bash
git add prototype/web/game.js prototype/web/index.html
git commit -m "feat: integrate TextPresenter with GameEngine"
```

---

## Task 7: Add Tag Support to Ink Parsing

**Files:**
- Modify: `prototype/web/game.js`

**Step 1: Extract PAUSA/CONTINUO tags during content parsing**

In `prototype/web/game.js`, find the `continueStory` function where tags are processed (around line 234-278). Add handling for PAUSA and CONTINUO tags:

In the tag processing loop, add this case:

```javascript
                } else if (tag === 'PAUSA' || tag === 'CONTINUO') {
                    // Store for TextPresenter
                    if (currentBatch.length > 0) {
                        const lastItem = currentBatch[currentBatch.length - 1];
                        if (!lastItem.tags) lastItem.tags = [];
                        lastItem.tags.push(tag);
                    }
                }
```

This should be added in the `for (const tag of tags)` loop, before the final else clause.

**Step 2: Commit**

```bash
git add prototype/web/game.js
git commit -m "feat: parse PAUSA and CONTINUO tags for TextPresenter"
```

---

## Task 8: Add Example Tags to Ink Story

**Files:**
- Modify: `prototype/ink/personajes/tiago.ink`

**Step 1: Add PAUSA tags to dramatic moments**

In `prototype/ink/personajes/tiago.ink`, find `tiago_se_abre` (around line 68) and add PAUSA tags:

```ink
=== tiago_se_abre ===
// Escena Viernes/Sábado: Si tiago_confianza >= 2

{tiago_confianza >= 2:
    Tiago se sienta a tu lado.
    No dice nada.

    Después de un rato:

    "Mi vieja está internada.
    En el Vilardebó." # PAUSA

    No te mira.

    "No voy a visitarla.
    No puedo." # PAUSA
```

**Step 2: Recompile Ink**

Run: `./bin/inklecate -o prototype/web/un_dia_mas.json prototype/ink/main.ink && echo "var storyContent = $(cat prototype/web/un_dia_mas.json);" > prototype/web/un_dia_mas.js`
Expected: Compiles without errors

**Step 3: Commit**

```bash
git add prototype/ink/personajes/tiago.ink prototype/web/un_dia_mas.js prototype/web/un_dia_mas.json
git commit -m "feat: add PAUSA tags to tiago_se_abre scene"
```

---

## Task 9: Final Testing and Polish

**Files:**
- Review all modified files

**Step 1: Test fade-in animation**

1. Open game in browser
2. Start new game
3. Observe paragraphs appearing with fade-in, not all at once
Expected: Smooth sequential fade-in of paragraphs

**Step 2: Test pause heuristics**

1. Play until a scene with short lines (lunes morning, or tiago scenes)
2. Observe pause indicator appears after dramatic short lines
3. Click to continue
Expected: "▼" indicator pulses, clicking continues story

**Step 3: Test typewriter**

1. Open Settings > Enable "Efecto máquina de escribir"
2. Advance to next scene
3. Observe text appearing letter by letter
Expected: Typewriter effect with pauses on punctuation

**Step 4: Test reduced motion**

1. In browser DevTools, enable "Emulate CSS media feature prefers-reduced-motion"
2. Reload game
3. Observe text appears instantly
Expected: No animations when reduced motion is preferred

**Step 5: Test mobile tap**

1. Open game on mobile device or emulator
2. During pause, tap anywhere
Expected: Story continues

**Step 6: Final commit**

```bash
git add -A
git commit -m "feat: complete text presentation system

- Fade-in paragraph animations (450ms)
- Dramatic pauses via # PAUSA tag and heuristics
- Optional typewriter effect with variable punctuation timing
- Pause indicator with click/tap to continue
- Respects prefers-reduced-motion
- Mobile-friendly tap to continue"
```

---

## Summary

| Task | Description | Files |
|------|-------------|-------|
| 1 | Module skeleton | text-presenter.js |
| 2 | Fade-in rendering | text-presenter.js, style.css |
| 3 | Pause detection | text-presenter.js |
| 4 | Pause indicator | text-presenter.js, style.css |
| 5 | Typewriter effect | text-presenter.js |
| 6 | GameEngine integration | game.js, index.html |
| 7 | Tag parsing | game.js |
| 8 | Example tags in Ink | tiago.ink |
| 9 | Testing and polish | All files |

**Total: 9 tasks, ~15 commits**
