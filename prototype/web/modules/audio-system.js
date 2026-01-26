/**
 * AudioSystem - Background music and sound effects management
 * Handles BGM transitions by day and narrative events
 */
const AudioSystem = (function() {
    'use strict';

    let bgmElement = null;
    let sfxElement = null;
    let currentBGM = null;
    let config = null;
    let enabled = true;
    let bgmVolume = 0.3;
    let sfxVolume = 0.5;
    let fadeInterval = null;
    let initialized = false;

    /**
     * Initialize the audio system
     */
    function init() {
        if (initialized) return;

        // Create audio elements
        bgmElement = new Audio();
        bgmElement.loop = true;
        bgmElement.volume = bgmVolume;

        sfxElement = new Audio();
        sfxElement.volume = sfxVolume;

        // Load config
        loadConfig();

        // Load saved preferences
        loadPreferences();

        initialized = true;
        console.log('[AudioSystem] Initialized');
    }

    /**
     * Load audio configuration
     */
    function loadConfig() {
        try {
            if (typeof ConfigManager !== 'undefined') {
                // Try loading from config manager
                const audioConfig = ConfigManager.get('audio');
                if (audioConfig) {
                    config = audioConfig;
                    return;
                }
            }

            // Fallback: fetch config file
            fetch('config/audio-config.json')
                .then(r => r.json())
                .then(data => {
                    config = data;
                    console.log('[AudioSystem] Config loaded');
                })
                .catch(e => {
                    console.warn('[AudioSystem] Could not load audio config:', e);
                    config = getDefaultConfig();
                });
        } catch (e) {
            config = getDefaultConfig();
        }
    }

    /**
     * Default config if file is not available
     */
    function getDefaultConfig() {
        return {
            bgm: {
                lunes: { track: 'bgm_rutina', mood: 'neutral' },
                martes: { track: 'bgm_tension', mood: 'tension' },
                miercoles: { track: 'bgm_despido', mood: 'dark' },
                jueves: { track: 'bgm_vacio', mood: 'melancholy' },
                viernes: { track: 'bgm_crisis', mood: 'urgent' },
                sabado: { track: 'bgm_asamblea', mood: 'hopeful' },
                domingo: { track: 'bgm_reflexion', mood: 'contemplative' }
            },
            sfx: {
                dice_roll: 'sfx_dados',
                dice_success: 'sfx_exito',
                dice_fail: 'sfx_fallo',
                stat_up: 'sfx_subida',
                stat_down: 'sfx_bajada',
                idea_unlock: 'sfx_idea',
                save: 'sfx_guardar',
                ending: 'sfx_final'
            },
            fadeMs: 2000,
            enabled: true
        };
    }

    /**
     * Load preferences from localStorage
     */
    function loadPreferences() {
        try {
            const saved = localStorage.getItem('undiamas_audio_prefs');
            if (saved) {
                const prefs = JSON.parse(saved);
                enabled = prefs.enabled !== undefined ? prefs.enabled : true;
                bgmVolume = prefs.bgmVolume !== undefined ? prefs.bgmVolume : 0.3;
                sfxVolume = prefs.sfxVolume !== undefined ? prefs.sfxVolume : 0.5;

                if (bgmElement) bgmElement.volume = bgmVolume;
                if (sfxElement) sfxElement.volume = sfxVolume;
            }
        } catch (e) {
            console.warn('[AudioSystem] Could not load audio preferences');
        }
    }

    /**
     * Save preferences to localStorage
     */
    function savePreferences() {
        try {
            localStorage.setItem('undiamas_audio_prefs', JSON.stringify({
                enabled,
                bgmVolume,
                sfxVolume
            }));
        } catch (e) {
            console.warn('[AudioSystem] Could not save audio preferences');
        }
    }

    /**
     * Set BGM for a specific day
     * @param {string} dayName - Day name (lunes, martes, etc.)
     */
    function setDayBGM(dayName) {
        if (!enabled || !config) return;

        const dayConfig = config.bgm?.[dayName.toLowerCase()];
        if (!dayConfig) return;

        const track = dayConfig.track;
        if (track === currentBGM) return;

        // Crossfade to new track
        fadeOut(() => {
            currentBGM = track;
            // Note: actual audio files not included yet
            // bgmElement.src = `assets/audio/${track}.mp3`;
            // bgmElement.play().catch(e => {});
            console.log(`[AudioSystem] BGM: ${track} (${dayConfig.mood})`);
        });
    }

    /**
     * Play a sound effect
     * @param {string} sfxName - SFX identifier
     */
    function playSFX(sfxName) {
        if (!enabled || !config) return;

        const track = config.sfx?.[sfxName];
        if (!track) return;

        // Note: actual audio files not included yet
        // sfxElement.src = `assets/audio/${track}.mp3`;
        // sfxElement.play().catch(e => {});
        console.log(`[AudioSystem] SFX: ${track}`);
    }

    /**
     * Fade out current BGM
     * @param {Function} callback - Called when fade completes
     */
    function fadeOut(callback) {
        if (fadeInterval) clearInterval(fadeInterval);

        if (!bgmElement || bgmElement.paused) {
            if (callback) callback();
            return;
        }

        const fadeMs = config?.fadeMs || 2000;
        const steps = 20;
        const stepTime = fadeMs / steps;
        const volumeStep = bgmElement.volume / steps;

        fadeInterval = setInterval(() => {
            if (bgmElement.volume > volumeStep) {
                bgmElement.volume -= volumeStep;
            } else {
                bgmElement.volume = 0;
                bgmElement.pause();
                bgmElement.volume = bgmVolume;
                clearInterval(fadeInterval);
                fadeInterval = null;
                if (callback) callback();
            }
        }, stepTime);
    }

    /**
     * Process an audio tag from Ink
     * @param {string} tag - Tag like "AUDIO:bgm_rutina" or "AUDIO:sfx_dados"
     */
    function processTag(tag) {
        if (!tag || !tag.startsWith('AUDIO:')) return;

        const value = tag.substring(6).trim();
        if (value.startsWith('bgm_')) {
            currentBGM = value;
            console.log(`[AudioSystem] BGM tag: ${value}`);
        } else if (value.startsWith('sfx_')) {
            playSFX(value.replace('sfx_', ''));
            console.log(`[AudioSystem] SFX tag: ${value}`);
        }
    }

    /**
     * Toggle audio on/off
     */
    function toggle() {
        enabled = !enabled;
        if (!enabled) {
            if (bgmElement) {
                bgmElement.pause();
            }
        }
        savePreferences();
        return enabled;
    }

    /**
     * Set BGM volume (0-1)
     */
    function setBGMVolume(vol) {
        bgmVolume = Math.max(0, Math.min(1, vol));
        if (bgmElement) bgmElement.volume = bgmVolume;
        savePreferences();
    }

    /**
     * Set SFX volume (0-1)
     */
    function setSFXVolume(vol) {
        sfxVolume = Math.max(0, Math.min(1, vol));
        if (sfxElement) sfxElement.volume = sfxVolume;
        savePreferences();
    }

    /**
     * Check if audio is enabled
     */
    function isEnabled() {
        return enabled;
    }

    // Public API
    return {
        init,
        setDayBGM,
        playSFX,
        processTag,
        toggle,
        setBGMVolume,
        setSFXVolume,
        isEnabled,
        fadeOut
    };
})();

if (typeof window !== 'undefined') {
    window.AudioSystem = AudioSystem;
}
