/**
 * StatsPanel - Expandable stats display with thresholds and indicators
 */
const StatsPanel = (function() {
    'use strict';

    let story = null;
    let container = null;
    let isExpanded = false;
    let gameStarted = false;
    let previousStats = {};

    /**
     * Initialize the stats panel
     * @param {object} inkStory - The inkjs story instance
     * @param {HTMLElement} statusContainer - The status bar container
     */
    function init(inkStory, statusContainer) {
        story = inkStory;
        container = statusContainer;

        // Add expand/collapse click handler
        container.addEventListener('click', handlePanelClick);

        // Initial render
        saveCurrentStats();
        render();
    }

    /**
     * Handle click on the panel
     */
    function handlePanelClick(e) {
        // Don't toggle if clicking on a button or interactive element
        if (e.target.tagName === 'BUTTON' || e.target.closest('button')) {
            return;
        }
        toggle();
    }

    /**
     * Toggle panel expanded state
     */
    function toggle() {
        isExpanded = !isExpanded;
        container.classList.toggle('expanded', isExpanded);
        render();
    }

    /**
     * Set game started flag
     * @param {boolean} started
     */
    function setGameStarted(started) {
        gameStarted = started;
        render();
    }

    /**
     * Save current stat values for change detection
     */
    function saveCurrentStats() {
        if (!story) return;

        try {
            const stats = ConfigManager.getAllStats();
            for (const statId in stats) {
                const stat = stats[statId];
                previousStats[statId] = story.variablesState[statId] ?? stat.default;
            }
        } catch (e) {
            console.warn('Error saving stats:', e);
        }
    }

    /**
     * Get current stat value
     * @param {string} statId
     * @returns {number}
     */
    function getStatValue(statId) {
        if (!story) return 0;
        const stat = ConfigManager.getStat(statId);
        return story.variablesState[statId] ?? (stat ? stat.default : 0);
    }

    /**
     * Check if stat changed
     * @param {string} statId
     * @returns {number} - Difference (0 if no change)
     */
    function getStatChange(statId) {
        const current = getStatValue(statId);
        const previous = previousStats[statId] ?? current;
        return current - previous;
    }

    /**
     * Get active threshold indicators
     * @returns {Array<object>}
     */
    function getActiveIndicators() {
        const indicators = [];
        const stats = ConfigManager.getAllStats();

        for (const statId in stats) {
            const threshold = ConfigManager.getThreshold(statId);
            if (!threshold) continue;

            const value = getStatValue(statId);

            if (threshold.high !== undefined && value >= threshold.high) {
                indicators.push({
                    statId,
                    type: 'high',
                    label: threshold.effects?.indicator || `${statId} alto`,
                    class: threshold.effects?.bodyClass || ''
                });
            }

            if (threshold.low !== undefined && value <= threshold.low) {
                indicators.push({
                    statId,
                    type: 'low',
                    label: threshold.effects?.indicator || `${statId} bajo`,
                    class: threshold.effects?.bodyClass || ''
                });
            }
        }

        return indicators;
    }

    /**
     * Apply threshold effects to body
     */
    function applyThresholdEffects() {
        // Remove all threshold classes first
        document.body.classList.remove('trauma-high', 'llama-low', 'conexion-low');

        const indicators = getActiveIndicators();
        indicators.forEach(ind => {
            if (ind.class) {
                document.body.classList.add(ind.class);
            }
        });
    }

    /**
     * Create icon HTML
     */
    function iconHTML(name, size = 16) {
        return `<i data-lucide="${name}" style="width:${size}px;height:${size}px;"></i>`;
    }

    /**
     * Create stat bar HTML
     * @param {number} value - Current value
     * @param {number} max - Maximum value
     * @param {string} color - Bar color
     * @param {boolean} segmented - Use segmented display
     */
    function createStatBar(value, max, color, segmented = false) {
        if (segmented) {
            const filled = '●'.repeat(Math.max(0, value));
            const empty = '○'.repeat(Math.max(0, max - value));
            return `<span class="stat-bar segmented">${filled}${empty}</span>`;
        }

        const percent = Math.max(0, Math.min(100, (value / max) * 100));
        return `
            <div class="stat-bar-container">
                <div class="stat-bar-fill" style="width: ${percent}%; background-color: ${color};"></div>
            </div>
        `;
    }

    /**
     * Render the stats panel
     */
    function render() {
        if (!container) return;

        // Apply threshold effects
        applyThresholdEffects();

        if (!gameStarted) {
            container.innerHTML = '<span class="status-phase">CREACIÓN DE PERSONAJE</span>';
            container.classList.remove('expanded');
            return;
        }

        const diaActual = story?.variablesState['dia_actual'] ?? 1;
        const diaNombre = ConfigManager.getDayName(diaActual);
        const energia = getStatValue('energia');
        const energiaMax = ConfigManager.getStat('energia')?.max || 5;

        // Get indicators
        const indicators = getActiveIndicators();
        const indicatorHTML = indicators.length > 0
            ? `<div class="threshold-indicators">${indicators.map(i =>
                `<span class="indicator indicator-${i.type}" title="${i.label}">${i.label}</span>`
            ).join('')}</div>`
            : '';

        // Header (always visible)
        let html = `
            <div class="status-header">
                <div class="status-row status-main">
                    <span class="status-day">${diaNombre}</span>
                    <span class="status-energia" title="Energía disponible hoy">
                        <span class="stat-icon">${iconHTML('zap', 16)}</span>
                        ${createStatBar(energia, energiaMax, '#ffc107', true)}
                    </span>
                    <button class="panel-toggle" title="${isExpanded ? 'Colapsar' : 'Expandir'}">
                        ${iconHTML(isExpanded ? 'chevron-up' : 'chevron-down', 16)}
                    </button>
                </div>
                ${indicatorHTML}
            </div>
        `;

        // Expanded panel
        if (isExpanded) {
            const conexion = getStatValue('conexion');
            const dignidad = getStatValue('dignidad');
            const llama = getStatValue('llama');
            const trauma = getStatValue('trauma');

            html += `
                <div class="status-expanded">
                    <div class="stats-grid">
                        ${renderStatRow('conexion', conexion)}
                        ${renderStatRow('dignidad', dignidad)}
                        ${renderStatRow('llama', llama)}
                        ${trauma > 0 ? renderStatRow('trauma', trauma) : ''}
                    </div>
                    <div class="panel-actions">
                        <button class="btn-secondary btn-small" onclick="StatsPanel.showFullInfo()">
                            ${iconHTML('info', 14)} Más info
                        </button>
                    </div>
                </div>
            `;
        }

        container.innerHTML = html;

        // Refresh Lucide icons
        if (typeof lucide !== 'undefined') {
            lucide.createIcons();
        }
    }

    /**
     * Render a single stat row
     */
    function renderStatRow(statId, value) {
        const stat = ConfigManager.getStat(statId);
        if (!stat) return '';

        const max = stat.max || 10;
        const color = stat.color || '#666';
        const isSpecial = stat.isSpecial || false;

        return `
            <div class="stat-row ${isSpecial ? 'stat-special' : ''}" title="${stat.description || ''}">
                <span class="stat-icon" style="color: ${color}">${iconHTML(stat.icon, 16)}</span>
                <span class="stat-label">${stat.label}</span>
                ${createStatBar(value, max, color)}
                <span class="stat-value">${value}/${max}</span>
            </div>
        `;
    }

    /**
     * Show full info modal with all stats, relationships, and profile
     */
    function showFullInfo() {
        // Get profile data
        const perdida = story?.variablesState['perdida'] || '';
        const atadura = story?.variablesState['atadura'] || '';
        const posicion = story?.variablesState['posicion'] || '';
        const vinculo = story?.variablesState['vinculo'] || '';
        const tieneLauro = story?.variablesState['tiene_laburo'] ?? true;

        // Get hidden stats
        const trauma = getStatValue('trauma');
        const acumulacion = getStatValue('acumulacion');

        // Create modal
        const modal = document.createElement('div');
        modal.className = 'modal-overlay';
        modal.innerHTML = `
            <div class="modal-content">
                <div class="modal-header">
                    <h2>${iconHTML('user', 20)} Tu Situación</h2>
                    <button class="modal-close">${iconHTML('x', 20)}</button>
                </div>
                <div class="modal-body">
                    <section class="info-section">
                        <h3>Estado Laboral</h3>
                        <p class="${tieneLauro ? 'status-employed' : 'status-unemployed'}">
                            ${tieneLauro ? '💼 Empleado' : '⚠️ Sin trabajo'}
                        </p>
                    </section>

                    ${trauma > 0 || acumulacion > 0 ? `
                    <section class="info-section">
                        <h3>Estados Ocultos</h3>
                        ${trauma > 0 ? renderStatRow('trauma', trauma) : ''}
                        ${acumulacion > 0 ? renderStatRow('acumulacion', acumulacion) : ''}
                    </section>
                    ` : ''}

                    <section class="info-section">
                        <h3>Relaciones</h3>
                        <div class="relationships-grid" id="relationshipsGrid">
                            <!-- Filled by RelationshipsPanel if available -->
                            <p class="loading">Cargando relaciones...</p>
                        </div>
                    </section>

                    <section class="info-section">
                        <h3>Tu Perfil</h3>
                        <div class="profile-grid">
                            ${perdida ? `<div class="profile-item"><strong>Pérdida:</strong> ${perdida}</div>` : ''}
                            ${atadura ? `<div class="profile-item"><strong>Atadura:</strong> ${atadura}</div>` : ''}
                            ${posicion ? `<div class="profile-item"><strong>Posición:</strong> ${posicion}</div>` : ''}
                            ${vinculo ? `<div class="profile-item"><strong>Vínculo:</strong> <span class="vinculo-badge">${vinculo}</span></div>` : ''}
                        </div>
                    </section>
                </div>
            </div>
        `;

        document.body.appendChild(modal);

        // Populate relationships if RelationshipsPanel is available
        if (typeof RelationshipsPanel !== 'undefined') {
            const grid = modal.querySelector('#relationshipsGrid');
            grid.innerHTML = RelationshipsPanel.renderAll();
        } else {
            // Fallback: simple relationship display
            const grid = modal.querySelector('#relationshipsGrid');
            grid.innerHTML = renderSimpleRelationships();
        }

        // Refresh icons
        if (typeof lucide !== 'undefined') {
            lucide.createIcons();
        }

        // Close handlers
        modal.querySelector('.modal-close').addEventListener('click', () => modal.remove());
        modal.addEventListener('click', (e) => {
            if (e.target === modal) modal.remove();
        });
    }

    /**
     * Render simple relationships (fallback)
     */
    function renderSimpleRelationships() {
        const characters = ConfigManager.getAllCharacters();
        const vinculo = story?.variablesState['vinculo'] || '';

        let html = '';
        for (const charId in characters) {
            const char = characters[charId];
            const relation = story?.variablesState[char.relationVar] ?? 0;
            const maxRel = ConfigManager.get('characters.display.maxRelation', 5);
            const isVinculo = charId === vinculo;

            html += `
                <div class="relationship-item ${isVinculo ? 'is-vinculo' : ''}">
                    <span class="char-name" style="color: ${char.color}">${char.name}</span>
                    ${isVinculo ? '<span class="vinculo-star">★</span>' : ''}
                    <span class="char-role">${char.role}</span>
                    <span class="relation-hearts">
                        ${'❤️'.repeat(relation)}${'🖤'.repeat(maxRel - relation)}
                    </span>
                </div>
            `;
        }
        return html;
    }

    /**
     * Update the panel (call after story changes)
     */
    function update() {
        saveCurrentStats();
        render();
    }

    // Public API
    return {
        init,
        toggle,
        setGameStarted,
        render,
        update,
        showFullInfo,
        getStatValue,
        getStatChange,
        saveCurrentStats,
        getActiveIndicators
    };
})();

// Expose to window
if (typeof window !== 'undefined') {
    window.StatsPanel = StatsPanel;
}
