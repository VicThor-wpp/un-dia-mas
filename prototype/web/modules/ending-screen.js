/**
 * EndingScreen - End-of-game experience module
 * Displays ending card, stats summary, relationships, and "Libro de Finales"
 */
const EndingScreen = (function() {
    'use strict';

    const STORAGE_KEY = 'undm_unlocked_endings';
    let endingsConfig = null;

    /**
     * Initialize with endings configuration
     * @param {object} config - Loaded endings-config.json data
     */
    function init(config) {
        endingsConfig = config;
    }

    /**
     * Load endings config from JSON file
     * @returns {Promise<void>}
     */
    async function loadConfig() {
        try {
            const response = await fetch('config/endings-config.json');
            if (response.ok) {
                endingsConfig = await response.json();
            } else {
                console.warn('EndingScreen: endings-config.json not found');
            }
        } catch (e) {
            console.warn('EndingScreen: Could not load endings config:', e);
        }
    }

    /**
     * Show the ending screen
     * @param {string} endingName - The ending knot name (e.g., "final_la_llama")
     * @param {object} storyVariables - Object with key story variables
     */
    function show(endingName, storyVariables) {
        if (!endingsConfig) {
            console.warn('EndingScreen: No config loaded');
            return;
        }

        // Unlock this ending
        unlockEnding(endingName);

        const endingData = endingsConfig.endings[endingName];
        if (!endingData) {
            console.warn('EndingScreen: Unknown ending:', endingName);
            return;
        }

        const category = endingsConfig.categories[endingData.category];

        // Build the overlay
        const overlay = document.createElement('div');
        overlay.className = 'ending-overlay';
        overlay.setAttribute('role', 'dialog');
        overlay.setAttribute('aria-label', 'Pantalla de final');

        const card = document.createElement('div');
        card.className = 'ending-card';

        // Category label
        const categoryLabel = document.createElement('div');
        categoryLabel.className = 'ending-category';
        categoryLabel.style.color = category ? category.color : '#e8a838';
        categoryLabel.textContent = category ? category.label : '';
        card.appendChild(categoryLabel);

        // Title
        const title = document.createElement('h1');
        title.className = 'ending-title';
        title.textContent = endingData.title;
        card.appendChild(title);

        // Decorative separator
        const separator = document.createElement('div');
        separator.className = 'ending-separator';
        card.appendChild(separator);

        // Description
        const desc = document.createElement('p');
        desc.className = 'ending-description';
        desc.textContent = endingData.description;
        card.appendChild(desc);

        // Stats summary
        const statsSection = buildStatsSection(storyVariables);
        card.appendChild(statsSection);

        // Relationships summary
        const relSection = buildRelationshipsSection(storyVariables);
        card.appendChild(relSection);

        // Libro de Finales
        const bookSection = buildEndingsBook(endingName);
        card.appendChild(bookSection);

        // Replay button
        const replayBtn = document.createElement('button');
        replayBtn.className = 'ending-replay-btn';
        replayBtn.textContent = 'Volver a jugar';
        replayBtn.addEventListener('click', function() {
            window.location.reload();
        });
        card.appendChild(replayBtn);

        overlay.appendChild(card);
        document.body.appendChild(overlay);

        // Trigger fade-in
        requestAnimationFrame(function() {
            overlay.classList.add('ending-visible');
        });

        // Focus the card for accessibility
        card.setAttribute('tabindex', '-1');
        card.focus();
    }

    /**
     * Build the stats summary section
     * @param {object} vars - Story variables
     * @returns {HTMLElement}
     */
    function buildStatsSection(vars) {
        const section = document.createElement('div');
        section.className = 'ending-stats';

        const heading = document.createElement('h3');
        heading.className = 'ending-section-title';
        heading.textContent = 'Tu semana en numeros';
        section.appendChild(heading);

        const grid = document.createElement('div');
        grid.className = 'ending-stats-grid';

        const statDefs = [
            { key: 'energia', label: 'Energia', max: 5, color: 'var(--color-energia)' },
            { key: 'conexion', label: 'Conexion', max: 10, color: 'var(--color-conexion)' },
            { key: 'llama', label: 'Llama', max: 10, color: 'var(--color-llama)' },
            { key: 'inercia', label: 'Inercia', max: 10, color: '#607d8b' },
        ];

        for (const stat of statDefs) {
            const val = vars[stat.key] ?? 0;
            const pct = Math.round((val / stat.max) * 100);

            const item = document.createElement('div');
            item.className = 'ending-stat-item';

            item.innerHTML =
                '<div class="ending-stat-label">' + stat.label + '</div>' +
                '<div class="ending-stat-bar-bg">' +
                    '<div class="ending-stat-bar-fill" style="width:' + pct + '%;background:' + stat.color + '"></div>' +
                '</div>' +
                '<div class="ending-stat-value">' + val + '/' + stat.max + '</div>';

            grid.appendChild(item);
        }

        section.appendChild(grid);
        return section;
    }

    /**
     * Build the relationships summary section
     * @param {object} vars - Story variables
     * @returns {HTMLElement}
     */
    function buildRelationshipsSection(vars) {
        const section = document.createElement('div');
        section.className = 'ending-relationships';

        const heading = document.createElement('h3');
        heading.className = 'ending-section-title';
        heading.textContent = 'Relaciones';
        section.appendChild(heading);

        const grid = document.createElement('div');
        grid.className = 'ending-rel-grid';

        const characters = [
            { key: 'sofia_relacion', name: 'Sofia', id: 'sofia' },
            { key: 'elena_relacion', name: 'Elena', id: 'elena' },
            { key: 'diego_relacion', name: 'Diego', id: 'diego' },
            { key: 'marcos_relacion', name: 'Marcos', id: 'marcos' },
            { key: 'juan_relacion', name: 'Juan', id: 'juan' },
            { key: 'ixchel_relacion', name: 'Ixchel', id: 'ixchel' }
        ];

        const maxRel = 5;
        const vinculo = vars['vinculo'] || '';

        for (const char of characters) {
            const val = vars[char.key] ?? 0;
            const isVinculo = vinculo === char.id;

            const item = document.createElement('div');
            item.className = 'ending-rel-item' + (isVinculo ? ' ending-rel-vinculo' : '');

            let hearts = '';
            for (let i = 0; i < maxRel; i++) {
                if (i < val) {
                    hearts += '<span class="ending-heart ending-heart-full">\u2665</span>';
                } else {
                    hearts += '<span class="ending-heart ending-heart-empty">\u2665</span>';
                }
            }

            item.innerHTML =
                '<div class="ending-rel-name">' +
                    char.name +
                    (isVinculo ? ' <span class="ending-vinculo-star">\u2605</span>' : '') +
                '</div>' +
                '<div class="ending-rel-hearts">' + hearts + '</div>';

            grid.appendChild(item);
        }

        section.appendChild(grid);
        return section;
    }

    /**
     * Build the "Libro de Finales" section
     * @param {string} currentEnding - The ending just reached
     * @returns {HTMLElement}
     */
    function buildEndingsBook(currentEnding) {
        const section = document.createElement('div');
        section.className = 'ending-book';

        const heading = document.createElement('h3');
        heading.className = 'ending-section-title';
        heading.textContent = 'Libro de Finales';
        section.appendChild(heading);

        const unlocked = getUnlockedEndings();

        const counter = document.createElement('div');
        counter.className = 'ending-book-counter';
        const totalEndings = Object.keys(endingsConfig.endings).length;
        counter.textContent = unlocked.length + ' / ' + totalEndings + ' descubiertos';
        section.appendChild(counter);

        const grid = document.createElement('div');
        grid.className = 'ending-book-grid';

        for (const endingId in endingsConfig.endings) {
            const ending = endingsConfig.endings[endingId];
            const isUnlocked = unlocked.includes(endingId);
            const isCurrent = endingId === currentEnding;
            const category = endingsConfig.categories[ending.category];

            const item = document.createElement('div');
            item.className = 'ending-book-item' +
                (isUnlocked ? ' ending-book-unlocked' : ' ending-book-locked') +
                (isCurrent ? ' ending-book-current' : '');

            if (isUnlocked) {
                item.innerHTML =
                    '<div class="ending-book-title" style="color:' + (category ? category.color : '#e8a838') + '">' +
                        ending.title +
                    '</div>' +
                    '<div class="ending-book-cat">' + (category ? category.label : '') + '</div>';
            } else {
                item.innerHTML =
                    '<div class="ending-book-title ending-book-hidden">???</div>' +
                    '<div class="ending-book-cat">Sin descubrir</div>';
            }

            grid.appendChild(item);
        }

        section.appendChild(grid);
        return section;
    }

    /**
     * Mark an ending as unlocked in localStorage
     * @param {string} name - Ending identifier
     */
    function unlockEnding(name) {
        const unlocked = getUnlockedEndings();
        if (!unlocked.includes(name)) {
            unlocked.push(name);
            try {
                localStorage.setItem(STORAGE_KEY, JSON.stringify(unlocked));
            } catch (e) {
                console.warn('EndingScreen: Could not save to localStorage:', e);
            }
        }
    }

    /**
     * Get list of unlocked endings from localStorage
     * @returns {string[]}
     */
    function getUnlockedEndings() {
        try {
            const stored = localStorage.getItem(STORAGE_KEY);
            if (stored) {
                const parsed = JSON.parse(stored);
                if (Array.isArray(parsed)) {
                    return parsed;
                }
            }
        } catch (e) {
            console.warn('EndingScreen: Could not read localStorage:', e);
        }
        return [];
    }

    // Public API
    return {
        init,
        loadConfig,
        show,
        unlockEnding,
        getUnlockedEndings
    };
})();

// Expose globally
if (typeof window !== 'undefined') {
    window.EndingScreen = EndingScreen;
}
