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

    /**
     * Check if currently presenting
     */
    function isBusy() {
        return isPresenting;
    }

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

    // Public API
    return {
        init,
        present,
        continue: continue_,
        skipAll,
        isBusy,
        extractPresentationTags
    };
})();

// Expose globally
if (typeof window !== 'undefined') {
    window.TextPresenter = TextPresenter;
}
