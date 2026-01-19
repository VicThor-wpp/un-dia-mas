/**
 * ConfigManager - Centralized configuration management
 * Loads JSON config files and provides access with dot notation
 */
const ConfigManager = (function() {
    'use strict';

    let configs = {};
    let loaded = false;
    let listeners = {};

    /**
     * Load all configuration files
     * @returns {Promise<void>}
     */
    async function loadAll() {
        const configFiles = ['game', 'stats', 'characters', 'ui'];

        try {
            const promises = configFiles.map(async (name) => {
                const response = await fetch(`config/${name}.json`);
                if (!response.ok) {
                    console.warn(`Config file ${name}.json not found, using defaults`);
                    return { name, data: {} };
                }
                const data = await response.json();
                return { name, data };
            });

            const results = await Promise.all(promises);

            results.forEach(({ name, data }) => {
                configs[name] = data;
            });

            loaded = true;
            notifyListeners('loaded', configs);

        } catch (error) {
            console.error('Error loading configs:', error);
            // Use inline defaults if fetch fails (e.g., file:// protocol)
            loadDefaults();
        }
    }

    /**
     * Load default configs (fallback when fetch fails)
     */
    function loadDefaults() {
        configs = {
            game: {
                meta: { title: 'Un Día Más', version: '1.0.0' },
                dice: {
                    results: {
                        '2': { label: '¡ÉXITO CRÍTICO!', class: 'critical-success' },
                        '1': { label: 'Éxito', class: 'success' },
                        '0': { label: 'Tirada', class: 'neutral' },
                        '-1': { label: '¡FALLO CRÍTICO!', class: 'critical-failure' }
                    },
                    trackingVars: { lastRoll: 'ultima_tirada', lastResult: 'ultimo_resultado' }
                }
            },
            stats: {
                stats: {
                    energia: { label: 'Energía', icon: 'zap', max: 5, default: 4, color: '#ffc107', visible: true, showInHeader: true },
                    conexion: { label: 'Conexión', icon: 'users', max: 10, default: 5, color: '#4caf50', visible: true },
                    dignidad: { label: 'Dignidad', icon: 'shield', max: 10, default: 5, color: '#2196f3', visible: true },
                    llama: { label: 'Llama', icon: 'flame', max: 10, default: 3, color: '#ff6b35', visible: true, isSpecial: true },
                    trauma: { label: 'Trauma', icon: 'heart-crack', max: 10, default: 0, visible: false, showWhenPositive: true },
                    acumulacion: { label: 'Acumulación', icon: 'trending-up', max: 10, default: 0, visible: false, hiddenStat: true }
                },
                thresholds: {
                    trauma: { high: 4, effects: { bodyClass: 'trauma-high', indicator: 'Traumatizado' } },
                    llama: { low: 2, effects: { bodyClass: 'llama-low', indicator: 'Sin esperanza' } },
                    conexion: { low: 3, effects: { bodyClass: 'conexion-low', indicator: 'Aislado' } }
                }
            },
            characters: {
                characters: {
                    sofia: { name: 'Sofía', role: 'La de la olla', color: '#e89b7b', relationVar: 'sofia_relacion' },
                    elena: { name: 'Elena', role: 'La que recuerda', color: '#98b89e', relationVar: 'elena_relacion' },
                    diego: { name: 'Diego', role: 'El que llegó', color: '#d4a574', relationVar: 'diego_relacion' },
                    marcos: { name: 'Marcos', role: 'El quemado', color: '#7ba3c7', relationVar: 'marcos_relacion' },
                    juan: { name: 'Juan', role: 'El compañero', color: '#8b7b7b', relationVar: 'juan_relacion' }
                },
                display: { maxRelation: 5 }
            },
            ui: {
                layout: { maxParagraphsBeforePause: 4 },
                notifications: { duration: 2500, fadeOutDuration: 500 },
                days: { names: ['', 'LUNES', 'MARTES', 'MIÉRCOLES', 'JUEVES', 'VIERNES', 'SÁBADO', 'DOMINGO'] },
                features: { diceRolls: true, statNotifications: true, choiceBadges: true }
            }
        };
        loaded = true;
        notifyListeners('loaded', configs);
    }

    /**
     * Get config value using dot notation
     * @param {string} path - Dot notation path (e.g., 'stats.energia.max')
     * @param {*} defaultValue - Default value if path not found
     * @returns {*}
     */
    function get(path, defaultValue = null) {
        if (!path) return configs;

        const parts = path.split('.');
        let current = configs;

        for (const part of parts) {
            if (current === null || current === undefined || !(part in current)) {
                return defaultValue;
            }
            current = current[part];
        }

        return current;
    }

    /**
     * Get stat configuration
     * @param {string} statId - Stat identifier
     * @returns {object|null}
     */
    function getStat(statId) {
        return get(`stats.stats.${statId}`, null);
    }

    /**
     * Get all stats configuration
     * @returns {object}
     */
    function getAllStats() {
        return get('stats.stats', {});
    }

    /**
     * Get character configuration
     * @param {string} charId - Character identifier
     * @returns {object|null}
     */
    function getCharacter(charId) {
        return get(`characters.characters.${charId}`, null);
    }

    /**
     * Get all characters configuration
     * @returns {object}
     */
    function getAllCharacters() {
        return get('characters.characters', {});
    }

    /**
     * Get threshold configuration for a stat
     * @param {string} statId - Stat identifier
     * @returns {object|null}
     */
    function getThreshold(statId) {
        return get(`stats.thresholds.${statId}`, null);
    }

    /**
     * Get day name by number
     * @param {number} dayNum - Day number (1-7)
     * @returns {string}
     */
    function getDayName(dayNum) {
        const days = get('ui.days.names', ['', 'LUNES', 'MARTES', 'MIÉRCOLES', 'JUEVES', 'VIERNES', 'SÁBADO', 'DOMINGO']);
        return days[dayNum] || days[1];
    }

    /**
     * Get dice result info
     * @param {number} result - Dice result code
     * @returns {object}
     */
    function getDiceResult(result) {
        const results = get('game.dice.results', {});
        return results[String(result)] || { label: 'Tirada', class: 'neutral' };
    }

    /**
     * Check if a feature is enabled
     * @param {string} feature - Feature name
     * @returns {boolean}
     */
    function isFeatureEnabled(feature) {
        return get(`ui.features.${feature}`, false);
    }

    /**
     * Subscribe to config changes
     * @param {string} event - Event name
     * @param {function} callback - Callback function
     */
    function subscribe(event, callback) {
        if (!listeners[event]) {
            listeners[event] = [];
        }
        listeners[event].push(callback);
    }

    /**
     * Notify listeners of an event
     * @param {string} event - Event name
     * @param {*} data - Event data
     */
    function notifyListeners(event, data) {
        if (listeners[event]) {
            listeners[event].forEach(cb => cb(data));
        }
    }

    /**
     * Check if configs are loaded
     * @returns {boolean}
     */
    function isLoaded() {
        return loaded;
    }

    // Public API
    return {
        loadAll,
        loadDefaults,
        get,
        getStat,
        getAllStats,
        getCharacter,
        getAllCharacters,
        getThreshold,
        getDayName,
        getDiceResult,
        isFeatureEnabled,
        subscribe,
        isLoaded
    };
})();

// Auto-load if not in module context
if (typeof window !== 'undefined') {
    window.ConfigManager = ConfigManager;
}
