/**
 * Achievements - Meta-progression tracking across playthroughs
 */
const Achievements = (function() {
    'use strict';

    const STORAGE_KEY = 'undm_achievements';
    const VINCULO_KEY = 'undm_played_vinculos';
    let config = null;
    let unlocked = [];

    function init() {
        try {
            unlocked = JSON.parse(localStorage.getItem(STORAGE_KEY) || '[]');
        } catch(e) {
            unlocked = [];
        }
        loadConfig();
    }

    async function loadConfig() {
        try {
            const r = await fetch('config/achievements-config.json');
            if (r.ok) config = await r.json();
        } catch(e) {
            console.warn('[Achievements] Config not found');
        }
    }

    function check(endingName, storyVars) {
        if (!config) return;

        // Track vinculo for multi-playthrough achievement
        let playedVinculos = [];
        try {
            playedVinculos = JSON.parse(localStorage.getItem(VINCULO_KEY) || '[]');
        } catch(e) { playedVinculos = []; }

        if (storyVars && storyVars.vinculo && !playedVinculos.includes(storyVars.vinculo)) {
            playedVinculos.push(storyVars.vinculo);
            localStorage.setItem(VINCULO_KEY, JSON.stringify(playedVinculos));
        }

        let endings = [];
        try {
            endings = JSON.parse(localStorage.getItem('undm_unlocked_endings') || '[]');
        } catch(e) { endings = []; }

        Object.entries(config.achievements).forEach(([id, ach]) => {
            if (unlocked.includes(id)) return;

            let earned = false;
            switch(ach.condition) {
                case 'any_ending':
                    earned = true;
                    break;
                case 'all_endings':
                    earned = endings.length >= 12;
                    break;
                case 'all_category_colectivo':
                    earned = ['final_la_llama','final_red','final_tejido','final_lucha_colectiva']
                        .every(e => endings.includes(e));
                    break;
                case 'three_different_vinculos':
                    earned = playedVinculos.length >= 3;
                    break;
                default:
                    if (ach.condition.startsWith('ending_')) {
                        earned = endingName === ach.condition.replace('ending_', '');
                    }
            }

            if (earned) unlock(id, ach);
        });
    }

    function unlock(id, ach) {
        unlocked.push(id);
        localStorage.setItem(STORAGE_KEY, JSON.stringify(unlocked));
        if (typeof NotificationSystem !== 'undefined') {
            NotificationSystem.show(ach.title + ': ' + ach.description, 'success', 6000);
        }
    }

    function getUnlocked() { return [...unlocked]; }
    function getAll() { return config ? config.achievements : {}; }

    return { init, check, getUnlocked, getAll };
})();

if (typeof window !== 'undefined') {
    window.Achievements = Achievements;
}
