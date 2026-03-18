/**
 * TextPresenter - Handles paragraph animations with automatic flow
 * Updated: Continuous Flow (No click-to-continue pauses)
 */
const TextPresenter = (function() {
    'use strict';

    // Configuration
    const CONFIG = {
        baseDelay: 400,           // Minimum wait between paragraphs
        msPerWord: 50,            // Time allowance per word
        maxDelay: 2500,           // Maximum wait time
        fadeInDuration: 600       // CSS animation duration reference
    };

    // State
    let paragraphQueue = [];
    let isPresenting = false;
    let onComplete = null;
    let currentContainer = null;
    let activeTimeout = null;

    /**
     * Get current pacing mode from ReadingPreferences
     * @returns {'auto'|'click'|'fast'}
     */
    function getPacingMode() {
        if (typeof ReadingPreferences !== 'undefined' && ReadingPreferences.get) {
            return ReadingPreferences.get('pacing') || 'auto';
        }
        return 'auto';
    }

    function init() {
        // Setup global skip listener
        document.addEventListener('click', (e) => {
            // Ignore clicks on buttons/links
            if (e.target.closest('button, a, input, .glossary-term')) return;
            if (isPresenting) {
                const pacingMode = getPacingMode();
                if (pacingMode === 'click' && paragraphQueue.length > 0) {
                    // In click mode, advance one paragraph instead of skipping all
                    if (activeTimeout) clearTimeout(activeTimeout);
                    showNext();
                } else {
                    skipAll();
                }
            }
        });

        document.addEventListener('keydown', (e) => {
            if (e.key === ' ' || e.key === 'Enter') {
                if (isPresenting) {
                    const pacingMode = getPacingMode();
                    if (pacingMode === 'click' && paragraphQueue.length > 0) {
                        e.preventDefault();
                        if (activeTimeout) clearTimeout(activeTimeout);
                        showNext();
                    } else {
                        skipAll();
                    }
                }
            }
        });
    }

    function present(container, items, callback) {
        currentContainer = container;
        paragraphQueue = [...items];
        onComplete = callback;
        isPresenting = true;

        if (activeTimeout) clearTimeout(activeTimeout);
        showNext();
    }

    function showNext() {
        if (!isPresenting) return; // Stopped by skipAll

        if (paragraphQueue.length === 0) {
            finish();
            return;
        }

        const item = paragraphQueue.shift();
        const el = renderItem(item);
        
        // Calculate dynamic delay based on content length
        // This gives the user time to read THIS paragraph before the NEXT one appears
        const delay = calculateReadTime(item.content);

        const pacingMode = getPacingMode();

        if (paragraphQueue.length > 0) {
            switch (pacingMode) {
                case 'click':
                    // Don't auto-advance; wait for click/Space/Enter
                    // The existing skip listeners handle advancement
                    break;
                case 'fast':
                    activeTimeout = setTimeout(showNext, Math.floor(calculateReadTime(item.content) / 2));
                    break;
                default: // 'auto'
                    activeTimeout = setTimeout(showNext, delay);
            }
        } else {
            activeTimeout = setTimeout(finish, 500);
        }
    }

    /**
     * Calculate read time for natural pacing
     */
    function calculateReadTime(text) {
        if (!text) return CONFIG.baseDelay;
        
        // Strip HTML tags for word count
        const cleanText = text.replace(/<[^>]*>/g, '');
        const wordCount = cleanText.split(/\s+/).length;
        
        let time = CONFIG.baseDelay + (wordCount * CONFIG.msPerWord);
        
        // Cap the delay so it doesn't feel stuck
        return Math.min(time, CONFIG.maxDelay);
    }

    function finish() {
        isPresenting = false;
        if (onComplete) onComplete();
    }

    /**
     * Skip all animations and show everything immediately
     */
    function skipAll() {
        if (!isPresenting) return;
        
        if (activeTimeout) clearTimeout(activeTimeout);
        
        // Render remaining queue instantly
        while (paragraphQueue.length > 0) {
            const item = paragraphQueue.shift();
            renderItem(item, true);
        }
        
        // Force all existing paragraphs to visible state
        const paragraphs = currentContainer.querySelectorAll('.tp-paragraph:not(.tp-visible)');
        paragraphs.forEach(p => p.classList.add('tp-visible', 'tp-instant'));

        finish();
        
        // Scroll to bottom to ensure new content is seen
        // requestAnimationFrame(() => {
        //     currentContainer.lastElementChild?.scrollIntoView({ behavior: 'smooth', block: 'end' });
        // });
    }

    /**
     * Parse text for Glosa markup [Term|Def]
     */
    function parseGlosa(text) {
        if (!text) return '';
        // Sanitize the base text first
        const safeText = typeof SecurityValidator !== 'undefined'
            ? SecurityValidator.sanitizeHTML(text)
            : text;
        // Then process glossary markup with escaped values
        return safeText.replace(/\[(.*?)\|(.*?)\]/g, (match, term, def) => {
            const safeTerm = typeof SecurityValidator !== 'undefined'
                ? SecurityValidator.escapeHTML(term) : term;
            const safeDef = typeof SecurityValidator !== 'undefined'
                ? SecurityValidator.escapeAttr(def) : def;
            const safeDefHTML = typeof SecurityValidator !== 'undefined'
                ? SecurityValidator.escapeHTML(def) : def;
            return `<span class="glossary-term" tabindex="0" aria-label="${safeDef}">${safeTerm}<span class="glossary-tooltip">${safeDefHTML}</span></span>`;
        });
    }

    function renderItem(item, instant = false) {
        const el = document.createElement(item.type === 'header' ? 'h1' : 'div');
        const tags = item.tags || [];

        // Check for Voice tags
        const voiceTag = tags.find(t => t.startsWith('VOZ:'));
        let voiceClass = '';
        if (voiceTag) {
            voiceClass = 'voice-line voice-' + voiceTag.split(':')[1].toLowerCase().trim();
        }

        // Apply content and classes based on type
        switch (item.type) {
            case 'header':
                el.textContent = item.content;
                el.className = 'story-header tp-paragraph';
                break;
            case 'text':
                el.innerHTML = parseGlosa(item.content);
                el.className = voiceClass ? `${voiceClass} tp-paragraph` : 'story-text tp-paragraph';
                break;
            case 'idea':
                el.innerHTML = parseGlosa(item.content);
                el.className = 'tag-idea tp-paragraph';
                break;
            case 'fragmento':
                el.innerHTML = parseGlosa(item.content);
                el.className = 'tag-fragmento tp-paragraph';
                break;
            default:
                el.innerHTML = parseGlosa(item.content) || '';
                el.className = 'tp-paragraph';
        }

        currentContainer.appendChild(el);

        if (instant || prefersReducedMotion()) {
            el.classList.add('tp-instant', 'tp-visible');
        } else {
            // Trigger reflow
            el.offsetHeight; 
            requestAnimationFrame(() => el.classList.add('tp-visible'));
        }

        return el;
    }

    function prefersReducedMotion() {
        return window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    }

    function isTypewriterEnabled() {
        // Disabled for now to simplify flow
        return false; 
    }

    return {
        init,
        present,
        skipAll,
        isBusy: () => isPresenting
    };
})();

if (typeof window !== 'undefined') {
    window.TextPresenter = TextPresenter;
}
