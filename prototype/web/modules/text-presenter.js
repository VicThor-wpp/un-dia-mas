/**
 * TextPresenter - Handles paragraph animations, dramatic pauses, and styling
 * Updated for Phase 4: Glosa and Voices
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
        ',': 100, '.': 200, '!': 150, '?': 150, ';': 120, ':': 100, '…': 400
    };

    // State
    let paragraphQueue = [];
    let isPresenting = false;
    let isPaused = false;
    let onComplete = null;
    let currentContainer = null;

    function init() {}

    function present(container, items, callback) {
        currentContainer = container;
        paragraphQueue = [...items];
        onComplete = callback;
        isPresenting = true;
        isPaused = false;
        showNext();
    }

    function showNext() {
        if (paragraphQueue.length === 0) {
            isPresenting = false;
            if (onComplete) onComplete();
            return;
        }

        const item = paragraphQueue.shift();
        const tags = item.tags || [];

        // Determine if typewriter should be used
        // Disable typewriter for voices to avoid breaking layout
        const isVoice = tags.some(t => t.startsWith('VOZ:'));
        const useTypewriter = !isVoice && isTypewriterEnabled() && item.type === 'text' && !prefersReducedMotion();

        if (useTypewriter) {
            renderTypewriter(item, () => afterRender(item, tags));
        } else {
            renderItem(item);
            afterRender(item, tags);
        }
    }

    function afterRender(item, tags) {
        if (shouldPause(item, tags)) {
            isPaused = true;
            setTimeout(() => showPauseIndicator(), 100);
            return;
        }
        if (paragraphQueue.length > 0) {
            setTimeout(showNext, CONFIG.delayBetweenParagraphs);
        } else {
            isPresenting = false;
            if (onComplete) onComplete();
        }
    }

    function shouldPause(item, tags) {
        if (item.type === 'header') return false;
        if (tags.includes('CONTINUO')) return false;
        if (tags.includes('PAUSA')) return true;
        if (item.type !== 'text') return false;

        const text = item.content || '';
        const strippedText = text.replace(/<[^>]*>/g, '').trim();

        if (strippedText.length > 0 && strippedText.length <= CONFIG.pausePatterns.shortLine) {
            if (!strippedText.endsWith('?') && !strippedText.startsWith(',')) return true;
        }
        if (strippedText.endsWith(CONFIG.pausePatterns.ellipsis)) return true;
        return false;
    }

    function showPauseIndicator() {
        hidePauseIndicator();
        const indicator = document.createElement('div');
        indicator.className = 'pause-indicator';
        indicator.innerHTML = '<span class="pause-indicator-text">CONTINUAR</span><span class="pause-indicator-symbol">▼</span>';
        indicator.setAttribute('role', 'button');
        indicator.setAttribute('aria-label', 'Continuar leyendo');
        indicator.setAttribute('tabindex', '0');

        indicator.addEventListener('click', handleContinueInput);
        indicator.addEventListener('keydown', (e) => {
            if (e.key === 'Enter' || e.key === ' ') {
                e.preventDefault();
                handleContinueInput();
            }
        });

        currentContainer.appendChild(indicator);
        setTimeout(() => {
            document.addEventListener('click', handleDocumentClick);
            document.addEventListener('keydown', handleKeyPress);
        }, 100);
        indicator.scrollIntoView({ behavior: 'smooth', block: 'center' });
    }

    function handleContinueInput() {
        if (!isPaused) return;
        document.removeEventListener('click', handleDocumentClick);
        document.removeEventListener('keydown', handleKeyPress);
        continue_();
    }

    function handleDocumentClick(e) {
        if (e.target.closest('button, a, input, .modal-overlay, .glossary-term')) return;
        handleContinueInput();
    }

    function handleKeyPress(e) {
        if (e.key === 'Enter' || e.key === ' ') {
            e.preventDefault();
            handleContinueInput();
        }
    }

    function continue_() {
        if (!isPaused) return;
        isPaused = false;
        hidePauseIndicator();
        showNext();
    }

    function hidePauseIndicator() {
        const indicator = document.querySelector('.pause-indicator');
        if (indicator) indicator.remove();
    }

    function skipAll() {
        if (!isPresenting) return;
        for (const item of paragraphQueue) renderItem(item, true);
        paragraphQueue = [];
        isPresenting = false;
        hidePauseIndicator();
        if (onComplete) onComplete();
    }

    /**
     * Parse text for Glosa markup [Term|Def]
     */
    function parseGlosa(text) {
        if (!text) return '';
        return text.replace(/\[(.*?)\|(.*?)\]/g, (match, term, def) => {
            return `<span class="glossary-term" tabindex="0" aria-label="${def}">${term}<span class="glossary-tooltip">${def}</span></span>`;
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
                // Parse Glosa
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

        // AMBIENTE tags handling could happen here, but better in GameEngine global state
        
        currentContainer.appendChild(el);

        if (instant || prefersReducedMotion()) {
            el.classList.add('tp-instant');
        } else {
            el.offsetHeight; // Reflow
            requestAnimationFrame(() => el.classList.add('tp-visible'));
        }

        return el;
    }

    function prefersReducedMotion() {
        return window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    }

    function isTypewriterEnabled() {
        if (typeof ReadingPreferences !== 'undefined') {
            return ReadingPreferences.getPrefs().typewriter === true;
        }
        return false;
    }

    function renderTypewriter(item, callback) {
        const el = document.createElement(item.type === 'header' ? 'h1' : 'div');
        // Typewriter implies standard text, not voice usually
        el.className = item.type === 'header' ? 'story-header tp-paragraph tp-visible' : 'story-text tp-paragraph tp-visible';
        
        currentContainer.appendChild(el);
        // Pre-parse Glosa for typewriter (strip tags for typing, insert later? complex)
        // Simplification: Typewriter types HTML tags instantly
        typewriteText(el, parseGlosa(item.content), callback);
    }

    function typewriteText(el, text, callback) {
        el.innerHTML = '';
        let i = 0;
        const speed = CONFIG.typewriterBaseSpeed;

        function typeChar() {
            if (i >= text.length) {
                if (callback) callback();
                return;
            }

            if (text[i] === '<') {
                const tagEnd = text.indexOf('>', i);
                if (tagEnd !== -1) {
                    el.innerHTML += text.substring(i, tagEnd + 1);
                    i = tagEnd + 1;
                    typeChar();
                    return;
                }
            }

            const char = text[i];
            el.innerHTML += char;
            i++;

            let delay = speed;
            if (char === '.' && text.substring(i-3, i) === '...') delay = PUNCTUATION_DELAYS['…'];
            else if (PUNCTUATION_DELAYS[char]) delay = PUNCTUATION_DELAYS[char];

            setTimeout(typeChar, delay);
        }
        typeChar();
    }

    return {
        init,
        present,
        continue: continue_,
        skipAll,
        isBusy: () => isPresenting
    };
})();

if (typeof window !== 'undefined') {
    window.TextPresenter = TextPresenter;
}