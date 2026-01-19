/**
 * DecisionLog - Tracks important game events and decisions
 */
const DecisionLog = (function() {
    'use strict';

    let log = [];
    const MAX_ENTRIES = 50;

    /**
     * Create icon HTML
     */
    function iconHTML(name, size = 14) {
        return `<i data-lucide="${name}" style="width:${size}px;height:${size}px;"></i>`;
    }

    /**
     * Add entry to log
     * @param {string} type - Entry type: 'dice', 'stat', 'choice', 'event'
     * @param {object} data - Entry data
     */
    function add(type, data) {
        const entry = {
            type,
            data,
            timestamp: Date.now(),
            day: getCurrentDay()
        };

        log.push(entry);

        // Keep log size manageable
        if (log.length > MAX_ENTRIES) {
            log.shift();
        }
    }

    /**
     * Get current day from story
     */
    function getCurrentDay() {
        try {
            const story = GameEngine.getStory();
            return story?.variablesState['dia_actual'] ?? 1;
        } catch (e) {
            return 1;
        }
    }

    /**
     * Log a dice roll
     * @param {number} roll - Dice value
     * @param {number} result - Result code
     * @param {string} context - Optional context description
     */
    function logDice(roll, result, context = '') {
        add('dice', { roll, result, context });
    }

    /**
     * Log a stat change
     * @param {string} statId - Stat identifier
     * @param {number} oldValue - Previous value
     * @param {number} newValue - New value
     */
    function logStatChange(statId, oldValue, newValue) {
        const diff = newValue - oldValue;
        if (diff === 0) return;

        add('stat', { statId, oldValue, newValue, diff });
    }

    /**
     * Log a player choice
     * @param {string} choiceText - Text of the choice made
     */
    function logChoice(choiceText) {
        add('choice', { text: choiceText });
    }

    /**
     * Log a game event
     * @param {string} event - Event description
     * @param {string} type - Event type: 'info', 'warning', 'important'
     */
    function logEvent(event, type = 'info') {
        add('event', { text: event, eventType: type });
    }

    /**
     * Get all log entries
     */
    function getAll() {
        return [...log];
    }

    /**
     * Get recent entries
     * @param {number} count - Number of entries to return
     */
    function getRecent(count = 10) {
        return log.slice(-count);
    }

    /**
     * Clear the log
     */
    function clear() {
        log = [];
    }

    /**
     * Render log as HTML for modal
     */
    function renderHTML() {
        if (log.length === 0) {
            return '<p class="log-empty">No hay eventos registrados aún.</p>';
        }

        const dayNames = ['', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'];
        let html = '<div class="decision-log">';

        // Group by day
        const byDay = {};
        for (const entry of log) {
            if (!byDay[entry.day]) byDay[entry.day] = [];
            byDay[entry.day].push(entry);
        }

        // Render each day (most recent first)
        const days = Object.keys(byDay).sort((a, b) => b - a);
        for (const day of days) {
            const dayName = dayNames[day] || `Día ${day}`;
            html += `<div class="log-day"><h4>${dayName}</h4>`;

            for (const entry of byDay[day].reverse()) {
                html += renderEntry(entry);
            }

            html += '</div>';
        }

        html += '</div>';
        return html;
    }

    /**
     * Render a single log entry
     */
    function renderEntry(entry) {
        switch (entry.type) {
            case 'dice':
                return renderDiceEntry(entry.data);
            case 'stat':
                return renderStatEntry(entry.data);
            case 'choice':
                return renderChoiceEntry(entry.data);
            case 'event':
                return renderEventEntry(entry.data);
            default:
                return '';
        }
    }

    function renderDiceEntry(data) {
        const resultLabels = {
            2: 'Éxito crítico',
            1: 'Éxito',
            0: 'Neutral',
            '-1': 'Fallo crítico'
        };
        const resultClass = data.result >= 1 ? 'log-success' : (data.result < 0 ? 'log-fail' : 'log-neutral');
        const label = resultLabels[data.result] || 'Tirada';

        return `
            <div class="log-entry log-dice ${resultClass}">
                ${iconHTML('dices')}
                <span class="log-value">${data.roll}</span>
                <span class="log-label">${label}</span>
                ${data.context ? `<span class="log-context">${data.context}</span>` : ''}
            </div>
        `;
    }

    function renderStatEntry(data) {
        const stat = ConfigManager.getStat(data.statId);
        if (!stat) return '';

        const sign = data.diff > 0 ? '+' : '';
        const changeClass = data.diff > 0 ? 'log-positive' : 'log-negative';

        return `
            <div class="log-entry log-stat ${changeClass}">
                ${iconHTML(stat.icon)}
                <span class="log-stat-name">${stat.label}</span>
                <span class="log-change">${sign}${data.diff}</span>
                <span class="log-values">(${data.oldValue} → ${data.newValue})</span>
            </div>
        `;
    }

    function renderChoiceEntry(data) {
        const shortText = data.text.length > 40 ? data.text.substring(0, 40) + '...' : data.text;
        return `
            <div class="log-entry log-choice">
                ${iconHTML('mouse-pointer-click')}
                <span class="log-text">"${shortText}"</span>
            </div>
        `;
    }

    function renderEventEntry(data) {
        const icon = data.eventType === 'warning' ? 'alert-triangle' :
                     data.eventType === 'important' ? 'star' : 'info';
        return `
            <div class="log-entry log-event log-${data.eventType}">
                ${iconHTML(icon)}
                <span class="log-text">${data.text}</span>
            </div>
        `;
    }

    /**
     * Export log data for saving
     */
    function exportData() {
        return [...log];
    }

    /**
     * Import log data from save
     */
    function importData(data) {
        if (Array.isArray(data)) {
            log = data;
        }
    }

    // Public API
    return {
        add,
        logDice,
        logStatChange,
        logChoice,
        logEvent,
        getAll,
        getRecent,
        clear,
        renderHTML,
        exportData,
        importData
    };
})();

// Expose to window
if (typeof window !== 'undefined') {
    window.DecisionLog = DecisionLog;
}
