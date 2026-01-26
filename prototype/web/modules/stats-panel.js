/**
 * StatsPanel - Always visible stats display with key information
 */
const StatsPanel = (function() {
    'use strict';

    let story = null;
    let container = null;
    let gameStarted = false;
    let previousStats = {};

    /**
     * Initialize the stats panel
     */
    function init(inkStory, statusContainer) {
        story = inkStory;
        container = statusContainer;
        saveCurrentStats();
        render();
    }

    /**
     * Set game started flag
     */
    function setGameStarted(started) {
        gameStarted = started;
        render();
    }

    /**
     * Save current stat values
     */
    function saveCurrentStats() {
        if (!story) return;
        try {
            const stats = ConfigManager.getAllStats();
            for (const statId in stats) {
                previousStats[statId] = story.variablesState[statId] ?? stats[statId].default;
            }
        } catch (e) {
            console.warn('Error saving stats:', e);
        }
    }

    /**
     * Get current stat value
     */
    function getStatValue(statId) {
        if (!story) return 0;
        const stat = ConfigManager.getStat(statId);
        return story.variablesState[statId] ?? (stat ? stat.default : 0);
    }

    /**
     * Get stat change
     */
    function getStatChange(statId) {
        const current = getStatValue(statId);
        const previous = previousStats[statId] ?? current;
        return current - previous;
    }

    /**
     * Get active threshold indicators
     */
    function getActiveIndicators() {
        const indicators = [];
        const stats = ConfigManager.getAllStats();

        for (const statId in stats) {
            const threshold = ConfigManager.getThreshold(statId);
            if (!threshold) continue;

            const value = getStatValue(statId);

            if (threshold.high !== undefined && value >= threshold.high) {
                const highFx = threshold.highEffects || threshold.effects;
                indicators.push({
                    statId, type: 'high',
                    label: highFx?.indicator || `${statId} alto`,
                    class: highFx?.bodyClass || ''
                });
            }

            if (threshold.low !== undefined && value <= threshold.low) {
                indicators.push({
                    statId, type: 'low',
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
        document.body.classList.remove('salud-baja', 'llama-low', 'conexion-low', 'conexion-high', 'llama-high');
        getActiveIndicators().forEach(ind => {
            if (ind.class) document.body.classList.add(ind.class);
        });

        // Positive state thresholds
        const conexionValue = getStatValue('conexion');
        const llamaValue = getStatValue('llama');

        if (conexionValue >= 7) {
            document.body.classList.add('conexion-high');
        } else {
            document.body.classList.remove('conexion-high');
        }

        if (llamaValue >= 7) {
            document.body.classList.add('llama-high');
        } else {
            document.body.classList.remove('llama-high');
        }
    }

    /**
     * Create icon HTML
     */
    function iconHTML(name, size = 16) {
        return `<i data-lucide="${name}" style="width:${size}px;height:${size}px;"></i>`;
    }

    /**
     * Create stat display with number
     */
    function createStatDisplay(value, max, color) {
        return `<span class="stat-num" style="color:${color}">${value}/${max}</span>`;
    }

    /**
     * Create day progress indicator (7 dots for 7 days)
     */
    function createDayProgress(currentDay) {
        const days = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
        return `<div class="day-progress" title="Progreso de la semana">
            ${days.map((d, i) => {
                const dayNum = i + 1;
                let cls = 'day-dot';
                if (dayNum < currentDay) cls += ' past';
                else if (dayNum === currentDay) cls += ' current';
                return `<span class="${cls}" title="${getDayFullName(dayNum)}"></span>`;
            }).join('')}
        </div>`;
    }

    /**
     * Get full day name
     */
    function getDayFullName(day) {
        const names = ['', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'];
        return names[day] || '';
    }

    /**
     * Render the stats panel - Always visible
     */
    function render() {
        if (!container) return;
        applyThresholdEffects();

        if (!gameStarted) {
            container.innerHTML = `
                <div class="header-bar">
                    <span class="phase-label">CREACIÓN DE PERSONAJE</span>
                    <div class="actions-section">
                        <button class="header-btn" onclick="StartScreen.showManual()" title="Cómo jugar">
                            ${iconHTML('book-open', 18)}
                        </button>
                        <button class="header-btn" onclick="SaveSystem.showModal()" title="Guardar/Cargar">
                            ${iconHTML('save', 18)}
                        </button>
                    </div>
                </div>
            `;
            refreshIcons();
            return;
        }

        const diaActual = story?.variablesState['dia_actual'] ?? 1;
        const diaNombre = ConfigManager.getDayName(diaActual);

        // Get all stats
        const energia = getStatValue('energia');
        const energiaMax = ConfigManager.getStat('energia')?.max || 5;
        const conexion = getStatValue('conexion');
        const conexionMax = ConfigManager.getStat('conexion')?.max || 10;
        const llama = getStatValue('llama');
        const llamaMax = ConfigManager.getStat('llama')?.max || 10;
        const dignidad = getStatValue('dignidad');
        const dignidadMax = ConfigManager.getStat('dignidad')?.max || 10;
        const saludMental = getStatValue('salud_mental');

        // Get thresholds
        const indicators = getActiveIndicators();
        const alertsHTML = indicators.length > 0
            ? `<div class="alerts">${indicators.map(i =>
                `<span class="alert alert-${i.type}">${i.label}</span>`
            ).join('')}</div>`
            : '';

        container.innerHTML = `
            <div class="header-bar">
                <div class="day-section">
                    <span class="day-name">${diaNombre}</span>
                    ${createDayProgress(diaActual)}
                </div>

                <div class="stats-section">
                    <div class="stat-item" title="Energía: acciones disponibles hoy">
                        ${iconHTML('zap', 14)}
                        ${createStatDisplay(energia, energiaMax, '#ffc107')}
                    </div>
                    <div class="stat-item" title="Conexión: lazos con el barrio">
                        ${iconHTML('users', 14)}
                        ${createStatDisplay(conexion, conexionMax, '#4caf50')}
                    </div>
                    <div class="stat-item stat-llama" title="La Llama: esperanza colectiva">
                        ${iconHTML('flame', 14)}
                        ${createStatDisplay(llama, llamaMax, '#ff6b35')}
                    </div>
                    <div class="stat-item" title="Dignidad: respeto propio">
                        ${iconHTML('shield', 14)}
                        ${createStatDisplay(dignidad, dignidadMax, '#2196f3')}
                    </div>
                    <div class="stat-item stat-salud" title="Salud Mental: bienestar psicológico">
                        ${iconHTML('heart-pulse', 14)}
                        ${createStatDisplay(saludMental, 5, '#4fc3f7')}
                    </div>
                </div>

                <div class="actions-section">
                    <button class="header-btn" onclick="StatsPanel.showFullInfo()" title="Ver todo">
                        ${iconHTML('info', 18)}
                    </button>
                    <button class="header-btn" onclick="StartScreen.showManual()" title="Cómo jugar">
                        ${iconHTML('book-open', 18)}
                    </button>
                    <button class="header-btn" onclick="SaveSystem.showModal()" title="Guardar/Cargar">
                        ${iconHTML('save', 18)}
                    </button>
                </div>
            </div>
            ${alertsHTML}
        `;

        refreshIcons();
    }

    /**
     * Refresh Lucide icons
     */
    function refreshIcons() {
        if (typeof lucide !== 'undefined') {
            lucide.createIcons();
        }
    }

    /**
     * Show full info modal
     */
    function showFullInfo() {
        const tieneLauro = story?.variablesState['tiene_laburo'] ?? true;
        const perdida = story?.variablesState['perdida'] || '';
        const atadura = story?.variablesState['atadura'] || '';
        const posicion = story?.variablesState['posicion'] || '';
        const vinculo = story?.variablesState['vinculo'] || '';

        const modal = document.createElement('div');
        modal.className = 'modal-overlay';
        modal.innerHTML = `
            <div class="modal-content">
                <div class="modal-header">
                    <h2>${iconHTML('user', 20)} Estado Actual</h2>
                    <button class="modal-close">${iconHTML('x', 20)}</button>
                </div>
                <div class="modal-body">
                    <section class="info-section">
                        <h3>Situación Laboral</h3>
                        <p class="${tieneLauro ? 'status-employed' : 'status-unemployed'}">
                            ${tieneLauro ? '💼 Empleado' : '⚠️ Sin trabajo'}
                        </p>
                    </section>

                    <section class="info-section">
                        <h3>Recursos</h3>
                        <div class="full-stats">
                            ${renderFullStat('energia')}
                            ${renderFullStat('conexion')}
                            ${renderFullStat('dignidad')}
                            ${renderFullStat('llama')}
                            ${renderFullStat('salud_mental')}
                        </div>
                    </section>

                    <section class="info-section">
                        <h3>Relaciones</h3>
                        <div id="relGrid"></div>
                    </section>

                    ${(perdida || atadura || posicion) ? `
                    <section class="info-section">
                        <h3>Tu Historia</h3>
                        <div class="profile-list">
                            ${perdida ? `<div><strong>Pérdida:</strong> ${perdida}</div>` : ''}
                            ${atadura ? `<div><strong>Atadura:</strong> ${atadura}</div>` : ''}
                            ${posicion ? `<div><strong>Posición:</strong> ${posicion}</div>` : ''}
                            ${vinculo ? `<div><strong>Vínculo:</strong> <span class="vinculo-badge">${vinculo}</span></div>` : ''}
                        </div>
                    </section>
                    ` : ''}

                    <section class="info-section">
                        <h3>${iconHTML('lightbulb', 16)} Ideas Internalizadas</h3>
                        <div id="ideasContainer" class="ideas-container"></div>
                    </section>

                    <section class="info-section">
                        <h3>${iconHTML('scroll', 16)} Registro de Eventos</h3>
                        <div id="decisionLogContainer" class="decision-log-container"></div>
                    </section>
                </div>
            </div>
        `;

        document.body.appendChild(modal);

        // Fill relationships
        const relGrid = modal.querySelector('#relGrid');
        if (typeof RelationshipsPanel !== 'undefined') {
            relGrid.innerHTML = RelationshipsPanel.renderAll();
        }

        // Fill ideas
        const ideasContainer = modal.querySelector('#ideasContainer');
        if (ideasContainer && story) {
            ideasContainer.innerHTML = renderIdeas();
        }

        // Fill decision log
        const logContainer = modal.querySelector('#decisionLogContainer');
        if (logContainer && typeof DecisionLog !== 'undefined') {
            logContainer.innerHTML = DecisionLog.renderHTML();
        }

        refreshIcons();

        modal.querySelector('.modal-close').onclick = () => modal.remove();
        modal.onclick = (e) => { if (e.target === modal) modal.remove(); };
    }

    /**
     * Render active ideas list for modal
     */
    function renderIdeas() {
        if (!story) return '<p class="no-ideas">Sin ideas todav\u00eda.</p>';

        const ideaDefinitions = [
            { id: 'idea_tengo_tiempo', label: 'Tengo tiempo', type: 'elegida' },
            { id: 'idea_pedir_no_debilidad', label: 'Pedir no es debilidad', type: 'elegida' },
            { id: 'idea_hay_cosas_juntos', label: 'Hay cosas que se hacen juntos', type: 'elegida' },
            { id: 'idea_red_o_nada', label: 'La red o la nada', type: 'elegida' },
            { id: 'idea_quien_soy', label: '\u00bfQui\u00e9n soy?', type: 'involuntaria' },
            { id: 'idea_esto_es_lo_que_hay', label: 'Esto es lo que hay', type: 'involuntaria' }
        ];

        const activeIdeas = ideaDefinitions.filter(idea => {
            try {
                return story.variablesState[idea.id] === true || story.variablesState[idea.id] === 1;
            } catch (e) {
                return false;
            }
        });

        if (activeIdeas.length === 0) {
            return '<p class="no-ideas">Ninguna idea internalizada todav\u00eda.</p>';
        }

        let html = '<ul class="ideas-list">';
        activeIdeas.forEach(idea => {
            const typeClass = idea.type === 'involuntaria' ? 'idea-involuntaria' : 'idea-elegida';
            const typeLabel = idea.type === 'involuntaria' ? ' (involuntaria)' : '';
            html += `<li class="idea-item ${typeClass}">${iconHTML('sparkles', 14)} ${idea.label}${typeLabel}</li>`;
        });
        html += '</ul>';

        // Synergies
        try {
            const sinCol = story.variablesState['sinergia_colectiva'] || 0;
            const sinInd = story.variablesState['sinergia_individual'] || 0;
            if (sinCol >= 2 || sinInd >= 2) {
                html += '<div class="ideas-synergies">';
                if (sinCol >= 2) {
                    html += `<span class="synergy synergy-colectiva">${iconHTML('users', 14)} Sinergia colectiva</span>`;
                }
                if (sinInd >= 2) {
                    html += `<span class="synergy synergy-individual">${iconHTML('user', 14)} Sinergia individual</span>`;
                }
                html += '</div>';
            }
        } catch (e) {
            // Synergy variables not available yet
        }

        return html;
    }

    /**
     * Render full stat row for modal
     */
    function renderFullStat(statId) {
        const stat = ConfigManager.getStat(statId);
        if (!stat) return '';

        const value = getStatValue(statId);
        const max = stat.max || 10;
        const percent = (value / max) * 100;

        return `
            <div class="full-stat-row">
                <span class="stat-icon" style="color:${stat.color}">${iconHTML(stat.icon, 16)}</span>
                <span class="stat-name">${stat.label}</span>
                <div class="stat-bar-bg">
                    <div class="stat-bar-fill" style="width:${percent}%;background:${stat.color}"></div>
                </div>
                <span class="stat-val">${value}/${max}</span>
            </div>
        `;
    }

    /**
     * Update the panel
     */
    function update() {
        saveCurrentStats();
        render();
    }

    return {
        getPreviousStats: function() { return Object.assign({}, previousStats); },
        getStatDiff: function(statId) {
            const current = getStatValue(statId);
            const prev = previousStats[statId] !== undefined ? previousStats[statId] : current;
            return current - prev;
        },
        init,
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

if (typeof window !== 'undefined') {
    window.StatsPanel = StatsPanel;
}
