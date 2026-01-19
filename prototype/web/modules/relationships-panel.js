/**
 * RelationshipsPanel - NPC relationships and states visualization
 */
const RelationshipsPanel = (function() {
    'use strict';

    let story = null;

    /**
     * Initialize the relationships panel
     * @param {object} inkStory - The inkjs story instance
     */
    function init(inkStory) {
        story = inkStory;
    }

    /**
     * Create icon HTML
     */
    function iconHTML(name, size = 16) {
        return `<i data-lucide="${name}" style="width:${size}px;height:${size}px;"></i>`;
    }

    /**
     * Get relationship value for a character
     * @param {string} charId - Character identifier
     * @returns {number}
     */
    function getRelation(charId) {
        const char = ConfigManager.getCharacter(charId);
        if (!char || !story) return 0;
        return story.variablesState[char.relationVar] ?? 0;
    }

    /**
     * Get state for a character
     * @param {string} charId - Character identifier
     * @returns {string}
     */
    function getState(charId) {
        const char = ConfigManager.getCharacter(charId);
        if (!char || !story) return '';
        return story.variablesState[char.stateVar] ?? '';
    }

    /**
     * Check if character is the player's vinculo
     * @param {string} charId - Character identifier
     * @returns {boolean}
     */
    function isVinculo(charId) {
        if (!story) return false;
        return story.variablesState['vinculo'] === charId;
    }

    /**
     * Render a single character card
     * @param {string} charId - Character identifier
     * @returns {string} HTML
     */
    function renderCharacterCard(charId) {
        const char = ConfigManager.getCharacter(charId);
        if (!char) return '';

        const relation = getRelation(charId);
        const state = getState(charId);
        const maxRel = ConfigManager.get('characters.display.maxRelation', 5);
        const vinculo = isVinculo(charId);

        // State info
        let stateHTML = '';
        if (state && char.states && char.states[state]) {
            const stateInfo = char.states[state];
            stateHTML = `<span class="char-state" style="color: ${stateInfo.color}">${stateInfo.label}</span>`;
        }

        // Relation hearts
        const hearts = [];
        for (let i = 0; i < maxRel; i++) {
            if (i < relation) {
                hearts.push(`<span class="heart heart-full" style="color: ${char.color}">♥</span>`);
            } else {
                hearts.push('<span class="heart heart-empty">♡</span>');
            }
        }

        return `
            <div class="char-card ${vinculo ? 'char-vinculo' : ''}" data-char="${charId}">
                <div class="char-header">
                    <span class="char-name" style="color: ${char.color}">${char.name}</span>
                    ${vinculo ? `<span class="vinculo-badge" title="Tu vínculo especial">★</span>` : ''}
                </div>
                <p class="char-role">${char.role}</p>
                <div class="char-relation">
                    <span class="relation-hearts">${hearts.join('')}</span>
                </div>
                ${stateHTML}
                ${char.description ? `<p class="char-desc">${char.description}</p>` : ''}
            </div>
        `;
    }

    /**
     * Render all character cards
     * @returns {string} HTML
     */
    function renderAll() {
        const characters = ConfigManager.getAllCharacters();
        const vinculo = story?.variablesState['vinculo'] || '';

        // Sort: vinculo first, then alphabetically
        const charIds = Object.keys(characters).sort((a, b) => {
            if (a === vinculo) return -1;
            if (b === vinculo) return 1;
            return characters[a].name.localeCompare(characters[b].name);
        });

        return charIds.map(id => renderCharacterCard(id)).join('');
    }

    /**
     * Render a compact relationship list
     * @returns {string} HTML
     */
    function renderCompact() {
        const characters = ConfigManager.getAllCharacters();
        const vinculo = story?.variablesState['vinculo'] || '';
        const maxRel = ConfigManager.get('characters.display.maxRelation', 5);

        let html = '<div class="relationships-compact">';

        for (const charId in characters) {
            const char = characters[charId];
            const relation = getRelation(charId);
            const isVinc = charId === vinculo;

            const hearts = '♥'.repeat(relation) + '♡'.repeat(maxRel - relation);

            html += `
                <div class="rel-item ${isVinc ? 'rel-vinculo' : ''}">
                    <span class="rel-name" style="color: ${char.color}">${char.name}</span>
                    ${isVinc ? '<span class="rel-star">★</span>' : ''}
                    <span class="rel-hearts">${hearts}</span>
                </div>
            `;
        }

        html += '</div>';
        return html;
    }

    /**
     * Get relationship summary for save preview
     * @returns {object}
     */
    function getSummary() {
        const characters = ConfigManager.getAllCharacters();
        const summary = {};

        for (const charId in characters) {
            summary[charId] = {
                name: characters[charId].name,
                relation: getRelation(charId),
                state: getState(charId)
            };
        }

        return summary;
    }

    /**
     * Update the panel (if rendered standalone)
     */
    function update() {
        const container = document.getElementById('relationshipsPanel');
        if (container) {
            container.innerHTML = renderAll();
            if (typeof lucide !== 'undefined') {
                lucide.createIcons();
            }
        }
    }

    // Public API
    return {
        init,
        getRelation,
        getState,
        isVinculo,
        renderCharacterCard,
        renderAll,
        renderCompact,
        getSummary,
        update
    };
})();

// Expose to window
if (typeof window !== 'undefined') {
    window.RelationshipsPanel = RelationshipsPanel;
}
