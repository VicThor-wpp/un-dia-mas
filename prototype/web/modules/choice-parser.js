/**
 * ChoiceParser - Parse choice tags and build choice UI
 */
const ChoiceParser = (function() {
    'use strict';

    /**
     * Create icon HTML
     */
    function iconHTML(name, size = 16) {
        return `<i data-lucide="${name}" style="width:${size}px;height:${size}px;"></i>`;
    }

    /**
     * Parse choice tags into metadata object
     * @param {Array<string>} tags - Tags from choice
     * @returns {object}
     */
    function parseTags(tags) {
        const meta = {
            cost: 0,
            dice: false,
            stat: null,
            effects: [],
            isFalsa: false,
            tooltip: null,
            continueType: null,
            disabled: false
        };

        if (!tags) return meta;

        for (const tag of tags) {
            // COSTO:N - Energy cost
            if (tag.startsWith('COSTO:')) {
                meta.cost = parseInt(tag.split(':')[1]) || 0;
            }
            // DADOS - Simple dice roll
            else if (tag === 'DADOS') {
                meta.dice = true;
            }
            // DADOS:stat - Dice roll with stat modifier
            else if (tag.startsWith('DADOS:')) {
                meta.dice = true;
                meta.stat = tag.split(':')[1];
            }
            // STAT:stat - Shows stat icon
            else if (tag.startsWith('STAT:')) {
                meta.stat = tag.split(':')[1];
            }
            // EFECTO:stat+/stat-/stat? - Consequence indicator
            else if (tag.startsWith('EFECTO:')) {
                const effect = tag.split(':')[1];
                if (effect) {
                    meta.effects.push(effect);
                }
            }
            // FALSA - Fake choice (no real consequence)
            else if (tag === 'FALSA') {
                meta.isFalsa = true;
            }
            // TOOLTIP:text - Hover tooltip
            else if (tag.startsWith('TOOLTIP:')) {
                meta.tooltip = tag.split(':').slice(1).join(':');
            }
            // CONTINUAR:type - Continue button variant
            else if (tag.startsWith('CONTINUAR:')) {
                meta.continueType = tag.split(':')[1];
            }
            // DISABLED - Disabled choice
            else if (tag === 'DISABLED') {
                meta.disabled = true;
            }
        }

        return meta;
    }

    // Effect display mapping
    const EFFECT_DISPLAY = {
        '+': { symbol: '↑', class: 'effect-up' },
        '-': { symbol: '↓', class: 'effect-down' },
        '?': { symbol: '↑↓', class: 'effect-uncertain' },
        '+2': { symbol: '↑↑', class: 'effect-up' },
        '-2': { symbol: '↓↓', class: 'effect-down' }
    };

    /**
     * Build choice label HTML with badges
     * @param {string} text - Choice text
     * @param {object} meta - Parsed metadata
     * @param {object} story - Ink story instance
     * @returns {string}
     */
    function buildLabel(text, meta, story) {
        let badges = '';

        // Energy cost badge
        if (meta.cost > 0) {
            const currentEnergy = story?.variablesState['energia'] ?? 0;
            const hasEnergy = currentEnergy >= meta.cost;
            const costClass = hasEnergy ? 'cost-badge' : 'cost-badge cost-insufficient';
            badges += `<span class="${costClass}">${iconHTML('zap', 14)}${meta.cost}</span>`;
        }

        // Dice badge
        if (meta.dice) {
            let diceContent = iconHTML('dices', 14);
            if (meta.stat) {
                const statInfo = ConfigManager.getStat(meta.stat);
                if (statInfo) {
                    diceContent = `${iconHTML('dices', 14)}${iconHTML(statInfo.icon, 14)}`;
                }
            }
            badges += `<span class="dice-badge">${diceContent}</span>`;
        }

        // Effect badges
        for (const effect of meta.effects) {
            // Parse effect like "conexion+" or "dignidad-" or "llama?"
            let statName, modifier;

            // Check for +2/-2 modifiers first
            if (effect.endsWith('+2')) {
                statName = effect.slice(0, -2);
                modifier = '+2';
            } else if (effect.endsWith('-2')) {
                statName = effect.slice(0, -2);
                modifier = '-2';
            } else {
                statName = effect.slice(0, -1);
                modifier = effect.slice(-1);
            }

            const statInfo = ConfigManager.getStat(statName);
            const effectInfo = EFFECT_DISPLAY[modifier];

            if (statInfo && effectInfo) {
                badges += `<span class="effect-badge ${effectInfo.class}">${iconHTML(statInfo.icon, 14)}${effectInfo.symbol}</span>`;
            }
        }

        // Build final HTML
        // Sanitize text to prevent XSS from story content
        const safeText = typeof SecurityValidator !== 'undefined'
            ? SecurityValidator.sanitizeHTML(text)
            : text;

        if (badges) {
            return `<span class="choice-text">${safeText}</span><span class="choice-badges">${badges}</span>`;
        }

        return safeText;
    }

    /**
     * Check if a choice is available
     * @param {object} meta - Parsed metadata
     * @param {object} story - Ink story instance
     * @returns {boolean}
     */
    function isAvailable(meta, story) {
        if (meta.disabled) return false;

        if (meta.cost > 0) {
            const currentEnergy = story?.variablesState['energia'] ?? 0;
            return currentEnergy >= meta.cost;
        }

        return true;
    }

    /**
     * Build a complete choice button element
     * @param {object} choice - Ink choice object
     * @param {number} index - Choice index
     * @param {object} story - Ink story instance
     * @param {function} onClick - Click handler
     * @returns {HTMLElement}
     */
    function buildButton(choice, index, story, onClick) {
        const meta = parseTags(choice.tags);

        // Check if this is a "..." continue choice - render as continue button
        if (choice.text.trim() === '...') {
            const button = document.createElement('button');
            button.className = 'choice-button continue-button';
            button.dataset.choiceIndex = index;
            button.addEventListener('click', onClick);
            return button;
        }

        const button = document.createElement('button');
        button.className = 'choice-button';

        // Check availability
        if (!isAvailable(meta, story)) {
            button.classList.add('choice-unavailable');
        }

        // Mark fake choices
        if (meta.isFalsa) {
            button.classList.add('choice-falsa');
        }

        // Set tooltip if available
        if (meta.tooltip) {
            button.title = meta.tooltip;
        }

        // Build label
        button.innerHTML = buildLabel(choice.text, meta, story);
        button.dataset.choiceIndex = index;

        // Add click handler
        button.addEventListener('click', onClick);

        return button;
    }

    /**
     * Build a continue button
     * @param {string} type - Continue type (normal, espera, tension)
     * @param {function} onClick - Click handler
     * @returns {HTMLElement}
     */
    function buildContinueButton(type = 'normal', onClick) {
        const button = document.createElement('button');
        button.className = 'choice-button continue-button';

        if (type === 'espera') {
            button.classList.add('continue-espera');
        } else if (type === 'tension') {
            button.classList.add('continue-tension');
        }

        // Text content handled by CSS ::before
        button.textContent = '';

        button.addEventListener('click', onClick);

        return button;
    }

    // Public API
    return {
        parseTags,
        buildLabel,
        isAvailable,
        buildButton,
        buildContinueButton,
        EFFECT_DISPLAY
    };
})();

// Expose to window
if (typeof window !== 'undefined') {
    window.ChoiceParser = ChoiceParser;
}
