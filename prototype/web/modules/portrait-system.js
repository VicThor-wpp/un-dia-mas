/**
 * PortraitSystem - Character portrait display during dialogues
 */
const PortraitSystem = (function() {
    'use strict';

    let container = null;
    let activePortraits = {};
    let speakingChar = null;
    let enabled = false;

    /**
     * Initialize the portrait system
     */
    function init() {
        enabled = ConfigManager.get('ui.portraits.enabled', false);

        if (!enabled) return;

        // Create portrait container
        container = document.createElement('div');
        container.id = 'portraitContainer';
        container.className = 'portrait-container';
        document.getElementById('game').appendChild(container);

        // Check mobile breakpoint
        checkMobile();
        window.addEventListener('resize', checkMobile);
    }

    /**
     * Check if should hide on mobile
     */
    function checkMobile() {
        if (!container) return;

        const hideOnMobile = ConfigManager.get('ui.portraits.hideOnMobile', true);
        const breakpoint = ConfigManager.get('ui.portraits.mobileBreakpoint', 480);

        if (hideOnMobile && window.innerWidth <= breakpoint) {
            container.classList.add('hidden-mobile');
        } else {
            container.classList.remove('hidden-mobile');
        }
    }

    /**
     * Get portrait image path
     * @param {string} charId - Character ID
     * @param {string} expression - Expression name
     * @returns {string}
     */
    function getPortraitPath(charId, expression = 'neutral') {
        const char = ConfigManager.getCharacter(charId);
        if (!char || !char.portrait) return 'assets/portraits/placeholder.svg';

        // Check if expression exists for character
        if (char.expressions && char.expressions.includes(expression)) {
            return `${char.portrait}/${expression}.svg`;
        }

        // Fallback to neutral
        return `${char.portrait}/neutral.svg`;
    }

    /**
     * Show a character portrait
     * @param {string} charId - Character ID
     * @param {string} expression - Expression (neutral, happy, sad, etc.)
     * @param {string} position - Position (left, right, center)
     * @param {boolean} speaking - Is this character speaking?
     */
    function show(charId, expression = 'neutral', position = 'left', speaking = false) {
        if (!enabled || !container) return;

        const char = ConfigManager.getCharacter(charId);
        if (!char) return;

        // Create or update portrait element
        let portrait = container.querySelector(`[data-char="${charId}"]`);

        if (!portrait) {
            portrait = document.createElement('div');
            portrait.className = 'portrait';
            portrait.dataset.char = charId;
            portrait.innerHTML = `
                <img src="${getPortraitPath(charId, expression)}" alt="${char.name}" onerror="this.src='assets/portraits/placeholder.svg'">
                <span class="portrait-name" style="color: ${char.color}">${char.name}</span>
            `;
            container.appendChild(portrait);
        } else {
            // Update image if expression changed
            const img = portrait.querySelector('img');
            const newSrc = getPortraitPath(charId, expression);
            if (img.src !== newSrc) {
                img.src = newSrc;
            }
        }

        // Set position
        portrait.classList.remove('position-left', 'position-right', 'position-center');
        portrait.classList.add(`position-${position}`);

        // Set speaking state
        if (speaking) {
            setSpeaking(charId);
        }

        // Track active portrait
        activePortraits[charId] = { expression, position, speaking };

        // Trigger fade in
        portrait.classList.add('visible');
    }

    /**
     * Hide a character portrait
     * @param {string} charId - Character ID
     */
    function hide(charId) {
        if (!container) return;

        const portrait = container.querySelector(`[data-char="${charId}"]`);
        if (portrait) {
            portrait.classList.remove('visible');
            portrait.classList.add('hiding');

            setTimeout(() => {
                portrait.remove();
            }, 300);
        }

        delete activePortraits[charId];

        if (speakingChar === charId) {
            speakingChar = null;
        }
    }

    /**
     * Hide all portraits
     */
    function hideAll() {
        if (!container) return;

        const portraits = container.querySelectorAll('.portrait');
        portraits.forEach(portrait => {
            portrait.classList.remove('visible');
            portrait.classList.add('hiding');
        });

        setTimeout(() => {
            container.innerHTML = '';
        }, 300);

        activePortraits = {};
        speakingChar = null;
    }

    /**
     * Set which character is currently speaking
     * @param {string} charId - Character ID
     */
    function setSpeaking(charId) {
        if (!container) return;

        // Remove speaking state from all
        const portraits = container.querySelectorAll('.portrait');
        portraits.forEach(p => {
            p.classList.remove('speaking');
            p.classList.add('inactive');
        });

        // Add speaking state to active character
        const activePortrait = container.querySelector(`[data-char="${charId}"]`);
        if (activePortrait) {
            activePortrait.classList.add('speaking');
            activePortrait.classList.remove('inactive');
        }

        speakingChar = charId;
    }

    /**
     * Change expression for a visible character
     * @param {string} charId - Character ID
     * @param {string} expression - New expression
     */
    function setExpression(charId, expression) {
        if (!container || !activePortraits[charId]) return;

        const portrait = container.querySelector(`[data-char="${charId}"]`);
        if (portrait) {
            const img = portrait.querySelector('img');
            img.src = getPortraitPath(charId, expression);
            activePortraits[charId].expression = expression;
        }
    }

    /**
     * Process portrait tags from Ink
     * @param {Array<string>} tags - Tags from story
     */
    function processTags(tags) {
        if (!enabled || !tags) return;

        for (const tag of tags) {
            // PORTRAIT:charId,expression,position,speaking
            if (tag.startsWith('PORTRAIT:')) {
                const parts = tag.substring(9).split(',');
                const charId = parts[0]?.trim();
                const expression = parts[1]?.trim() || 'neutral';
                const position = parts[2]?.trim() || 'left';
                const speaking = parts[3]?.trim() === 'speaking';

                if (charId) {
                    show(charId, expression, position, speaking);
                }
            }
            // HIDE_PORTRAIT:charId
            else if (tag.startsWith('HIDE_PORTRAIT:')) {
                const charId = tag.substring(14).trim();
                if (charId) {
                    hide(charId);
                }
            }
            // HIDE_ALL_PORTRAITS
            else if (tag === 'HIDE_ALL_PORTRAITS') {
                hideAll();
            }
            // EXPRESSION:charId,expression
            else if (tag.startsWith('EXPRESSION:')) {
                const parts = tag.substring(11).split(',');
                const charId = parts[0]?.trim();
                const expression = parts[1]?.trim();

                if (charId && expression) {
                    setExpression(charId, expression);
                }
            }
            // SPEAKING:charId
            else if (tag.startsWith('SPEAKING:')) {
                const charId = tag.substring(9).trim();
                if (charId) {
                    setSpeaking(charId);
                }
            }
        }
    }

    /**
     * Get list of active portrait character IDs
     * @returns {Array<string>}
     */
    function getActivePortraits() {
        return Object.keys(activePortraits);
    }

    /**
     * Check if portraits are enabled
     * @returns {boolean}
     */
    function isEnabled() {
        return enabled;
    }

    /**
     * Enable or disable portraits at runtime
     * @param {boolean} enable
     */
    function setEnabled(enable) {
        enabled = enable;

        if (container) {
            container.style.display = enable ? '' : 'none';
        }

        if (!enable) {
            hideAll();
        }
    }

    // Public API
    return {
        init,
        show,
        hide,
        hideAll,
        setSpeaking,
        setExpression,
        processTags,
        getActivePortraits,
        isEnabled,
        setEnabled,
        getPortraitPath
    };
})();

// Expose to window
if (typeof window !== 'undefined') {
    window.PortraitSystem = PortraitSystem;
}
