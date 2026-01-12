// Un Día Más - Narrative Game Engine
// Visual feedback for dice rolls and stat changes

(function() {
    'use strict';

    let storyContainer, choicesContainer, statusContainer, notificationContainer;
    let story;

    const DIAS = ['', 'LUNES', 'MARTES', 'MIÉRCOLES', 'JUEVES', 'VIERNES', 'SÁBADO', 'DOMINGO'];

    let gameStarted = false;
    let previousStats = {};
    let previousDice = { ultima_tirada: 0, ultimo_resultado: 0 };

    let contentQueue = [];
    const MAX_PARAGRAPHS_BEFORE_PAUSE = 4;

    // Track active choice buttons for proper cleanup
    let activeChoiceButtons = [];

    // Stat labels and icons (Lucide icon names)
    const STAT_INFO = {
        energia: { label: 'Energía', icon: 'zap', max: 5 },
        conexion: { label: 'Conexión', icon: 'users', max: 10 },
        dignidad: { label: 'Dignidad', icon: 'shield', max: 10 },
        llama: { label: 'Llama', icon: 'flame', max: 10 },
        trauma: { label: 'Trauma', icon: 'heart-crack', max: 10 }
    };

    // Create Lucide icon SVG element
    function createIcon(name, size = 16) {
        const icon = document.createElement('i');
        icon.setAttribute('data-lucide', name);
        icon.style.width = size + 'px';
        icon.style.height = size + 'px';
        return icon;
    }

    // Render a Lucide icon as HTML string
    function iconHTML(name, size = 16) {
        return `<i data-lucide="${name}" style="width:${size}px;height:${size}px;"></i>`;
    }

    // Debounced icon initialization to avoid excessive DOM scanning
    let iconRefreshScheduled = false;
    function refreshIcons() {
        if (iconRefreshScheduled) return;
        iconRefreshScheduled = true;

        // Batch icon initialization using requestAnimationFrame
        requestAnimationFrame(() => {
            if (typeof lucide !== 'undefined') {
                lucide.createIcons();
            }
            iconRefreshScheduled = false;
        });
    }

    // Dice result labels
    const DICE_RESULTS = {
        2: { label: '¡ÉXITO CRÍTICO!', class: 'critical-success' },
        1: { label: 'Éxito', class: 'success' },
        0: { label: 'Tirada', class: 'neutral' },  // Simple roll, not a skill check
        '-1': { label: '¡FALLO CRÍTICO!', class: 'critical-failure' }
    };

    function init() {
        storyContainer = document.getElementById('storyContainer');
        choicesContainer = document.getElementById('choicesContainer');
        statusContainer = document.getElementById('statusContainer');

        // Create notification container
        notificationContainer = document.createElement('div');
        notificationContainer.id = 'notifications';
        notificationContainer.className = 'notifications';
        document.getElementById('game').insertBefore(notificationContainer, storyContainer);

        if (typeof storyContent === 'undefined') {
            console.error('storyContent not found.');
            return;
        }

        story = new inkjs.Story(storyContent);
        saveCurrentState();
        continueStory();
    }

    function saveCurrentState() {
        try {
            previousStats = {
                energia: story.variablesState['energia'] ?? 4,
                conexion: story.variablesState['conexion'] ?? 5,
                dignidad: story.variablesState['dignidad'] ?? 5,
                llama: story.variablesState['llama'] ?? 3,
                trauma: story.variablesState['trauma'] ?? 0
            };
            previousDice = {
                ultima_tirada: story.variablesState['ultima_tirada'] ?? 0,
                ultimo_resultado: story.variablesState['ultimo_resultado'] ?? 0
            };
        } catch(e) {}
    }

    function checkDiceRoll() {
        try {
            const currentTirada = story.variablesState['ultima_tirada'] ?? 0;
            const currentResultado = story.variablesState['ultimo_resultado'] ?? 0;

            // If dice was rolled (ultima_tirada changed and is not 0)
            if (currentTirada !== previousDice.ultima_tirada && currentTirada !== 0) {
                showDiceRoll(currentTirada, currentResultado);
            }

            previousDice = {
                ultima_tirada: currentTirada,
                ultimo_resultado: currentResultado
            };
        } catch(e) {}
    }

    function showDiceRoll(roll, result) {
        const resultInfo = DICE_RESULTS[result] || DICE_RESULTS[0];

        const rollDiv = document.createElement('div');
        rollDiv.className = `dice-roll ${resultInfo.class}`;
        rollDiv.innerHTML = `
            <span class="dice-icon">${iconHTML('dices', 20)}</span>
            <span class="dice-value">${roll}</span>
            <span class="dice-label">${resultInfo.label}</span>
        `;

        // Insert before the last paragraph or at the end
        storyContainer.appendChild(rollDiv);
        refreshIcons();

        // Also show as notification (0 = neutral for simple rolls)
        showNotification(`${roll} - ${resultInfo.label}`, result === 0 ? 0 : (result >= 1 ? 1 : -1), 'dice');
    }

    function checkStatChanges() {
        if (!gameStarted) return;

        try {
            const current = {
                energia: story.variablesState['energia'] ?? 4,
                conexion: story.variablesState['conexion'] ?? 5,
                dignidad: story.variablesState['dignidad'] ?? 5,
                llama: story.variablesState['llama'] ?? 3,
                trauma: story.variablesState['trauma'] ?? 0
            };

            for (const stat in current) {
                const diff = current[stat] - previousStats[stat];
                if (diff !== 0) {
                    const info = STAT_INFO[stat];
                    showNotification(info.label, diff, 'stat', info.icon);
                }
            }

            previousStats = current;
        } catch(e) {}
    }

    function showNotification(label, diff, type = 'stat', iconName = null) {
        const notif = document.createElement('div');

        let className = 'notification';
        let content = '';

        if (type === 'stat') {
            className += diff > 0 ? ' positive' : ' negative';
            const icon = iconName ? iconHTML(iconName, 16) : '';
            content = `${icon} ${label} ${diff > 0 ? '+' : ''}${diff}`;
        } else if (type === 'dice') {
            if (diff === 0) {
                className += ' dice-neutral';
            } else {
                className += diff >= 1 ? ' dice-success' : ' dice-fail';
            }
            content = `${iconHTML('dices', 16)} ${label}`;
        }

        notif.className = className;
        notif.innerHTML = content;
        notificationContainer.appendChild(notif);
        refreshIcons();

        // Use single timeout + animationend for cleaner cleanup
        setTimeout(() => {
            notif.classList.add('fade-out');
            notif.addEventListener('animationend', () => notif.remove(), { once: true });
        }, 2500);
    }

    function continueStory() {
        cleanupChoiceButtons();
        choicesContainer.innerHTML = '';
        contentQueue = [];

        let paragraphCount = 0;
        let currentBatch = [];

        while (story.canContinue) {
            const text = story.Continue();
            const tags = story.currentTags || [];

            // Check for dice roll after each continue
            checkDiceRoll();

            let hasHeader = false;
            for (const tag of tags) {
                if (tag.startsWith('IDEA DISPONIBLE:') || tag === 'IDEA') {
                    currentBatch.push({ type: 'idea', content: tag });
                } else if (tag.startsWith('MIENTRAS')) {
                    currentBatch.push({ type: 'fragmento', content: tag });
                } else {
                    hasHeader = true;
                    if (currentBatch.length > 0) {
                        contentQueue.push([...currentBatch]);
                        currentBatch = [];
                        paragraphCount = 0;
                    }
                    currentBatch.push({ type: 'header', content: tag });
                    if (DIAS.includes(tag)) {
                        gameStarted = true;
                    }
                }
            }

            if (text.trim()) {
                currentBatch.push({ type: 'text', content: text });
                paragraphCount++;

                if (paragraphCount >= MAX_PARAGRAPHS_BEFORE_PAUSE && !hasHeader) {
                    contentQueue.push([...currentBatch]);
                    currentBatch = [];
                    paragraphCount = 0;
                }
            }
        }

        if (currentBatch.length > 0) {
            contentQueue.push(currentBatch);
        }

        checkStatChanges();
        saveCurrentState();

        storyContainer.innerHTML = '';
        showNextBatch();
    }

    function showNextBatch() {
        if (contentQueue.length === 0) {
            showChoices();
            updateStatus();
            return;
        }

        const batch = contentQueue.shift();

        for (const item of batch) {
            const el = document.createElement(item.type === 'header' ? 'h1' : 'div');

            switch (item.type) {
                case 'header':
                    el.textContent = item.content;
                    el.className = 'story-header';
                    break;
                case 'text':
                    el.innerHTML = item.content;
                    el.className = 'story-text';
                    break;
                case 'idea':
                    el.textContent = item.content;
                    el.className = 'tag-idea';
                    break;
                case 'fragmento':
                    el.textContent = item.content;
                    el.className = 'tag-fragmento';
                    break;
            }
            storyContainer.appendChild(el);
        }

        checkStatChanges();
        checkDiceRoll();
        saveCurrentState();
        updateStatus();

        if (contentQueue.length > 0) {
            showContinueButton();
        } else {
            showChoices();
        }

        // Defer scroll to avoid blocking render
        requestAnimationFrame(() => {
            window.scrollTo(0, 0);
        });
    }

    function showContinueButton() {
        // Clean up previous buttons first
        cleanupChoiceButtons();

        const button = document.createElement('button');
        button.className = 'choice-button continue-button';
        // Text content is handled by CSS ::before pseudo-element
        button.textContent = '';

        const continueHandler = function() {
            cleanupChoiceButtons();
            choicesContainer.innerHTML = '';
            showNextBatch();
            // Use requestAnimationFrame to avoid blocking the main thread
            requestAnimationFrame(() => {
                storyContainer.lastElementChild?.scrollIntoView({ behavior: 'smooth', block: 'start' });
            });
        };

        button.addEventListener('click', continueHandler);
        activeChoiceButtons.push({ button, handler: continueHandler });
        choicesContainer.appendChild(button);
    }

    function parseChoiceTags(tags) {
        const meta = { cost: 0, dice: false, stat: null, effects: [], isFalsa: false };
        if (!tags) return meta;

        for (const tag of tags) {
            if (tag.startsWith('COSTO:')) {
                meta.cost = parseInt(tag.split(':')[1]) || 0;
            } else if (tag === 'DADOS') {
                meta.dice = true;
            } else if (tag.startsWith('DADOS:')) {
                meta.dice = true;
                meta.stat = tag.split(':')[1];
            } else if (tag.startsWith('STAT:')) {
                meta.stat = tag.split(':')[1];
            } else if (tag.startsWith('EFECTO:')) {
                // Parse effect tags like EFECTO:conexion+ or EFECTO:dignidad- or EFECTO:llama?
                const effect = tag.split(':')[1];
                if (effect) {
                    meta.effects.push(effect);
                }
            } else if (tag === 'FALSA') {
                meta.isFalsa = true;
            }
        }
        return meta;
    }

    // Map effect suffixes to display
    const EFFECT_DISPLAY = {
        '+': { symbol: '↑', class: 'effect-up' },
        '-': { symbol: '↓', class: 'effect-down' },
        '?': { symbol: '↑↓', class: 'effect-uncertain' }
    };

    function buildChoiceLabel(text, meta) {
        let badges = '';

        if (meta.cost > 0) {
            const hasEnergy = (story.variablesState['energia'] ?? 0) >= meta.cost;
            const costClass = hasEnergy ? 'cost-badge' : 'cost-badge cost-insufficient';
            badges += `<span class="${costClass}">${iconHTML('zap', 14)}${meta.cost}</span>`;
        }

        if (meta.dice) {
            let diceContent = iconHTML('dices', 14);
            if (meta.stat) {
                const statInfo = STAT_INFO[meta.stat];
                if (statInfo) {
                    diceContent = `${iconHTML('dices', 14)}${iconHTML(statInfo.icon, 14)}`;
                }
            }
            badges += `<span class="dice-badge">${diceContent}</span>`;
        }

        // Add effect badges
        for (const effect of meta.effects) {
            const statName = effect.slice(0, -1); // Remove last char (+, -, ?)
            const modifier = effect.slice(-1);    // Get last char
            const statInfo = STAT_INFO[statName];
            const effectInfo = EFFECT_DISPLAY[modifier];

            if (statInfo && effectInfo) {
                badges += `<span class="effect-badge ${effectInfo.class}">${iconHTML(statInfo.icon, 14)}${effectInfo.symbol}</span>`;
            }
        }

        if (badges) {
            return `<span class="choice-text">${text}</span><span class="choice-badges">${badges}</span>`;
        }
        return text;
    }

    // Clean up event listeners from previous choice buttons
    function cleanupChoiceButtons() {
        for (const { button, handler } of activeChoiceButtons) {
            button.removeEventListener('click', handler);
        }
        activeChoiceButtons = [];
    }

    function showChoices() {
        // Clean up previous event listeners before clearing
        cleanupChoiceButtons();
        choicesContainer.innerHTML = '';

        if (story.currentChoices.length > 0) {
            for (let i = 0; i < story.currentChoices.length; i++) {
                const choice = story.currentChoices[i];
                const meta = parseChoiceTags(choice.tags);

                const button = document.createElement('button');
                button.className = 'choice-button';

                // Check if player can afford the choice
                if (meta.cost > 0) {
                    const hasEnergy = (story.variablesState['energia'] ?? 0) >= meta.cost;
                    if (!hasEnergy) {
                        button.classList.add('choice-unavailable');
                    }
                }

                // Mark fake choices with subtle styling
                if (meta.isFalsa) {
                    button.classList.add('choice-falsa');
                }

                button.innerHTML = buildChoiceLabel(choice.text, meta);
                button.dataset.choiceIndex = i;
                button.addEventListener('click', onChoiceClick);
                // Track button and handler for cleanup
                activeChoiceButtons.push({ button, handler: onChoiceClick });
                choicesContainer.appendChild(button);
            }
            refreshIcons();
        }
    }

    // Cache for status bar element references
    let statusElements = null;
    let lastStatusValues = null;

    function initStatusBar() {
        statusContainer.innerHTML = `
            <div class="status-row status-main">
                <span class="status-day" data-stat="dia"></span>
                <span class="status-energia" title="Energía disponible hoy">
                    <span class="stat-icon">${iconHTML('zap', 16)}</span>
                    <span class="stat-bar" data-stat="energia-bar"></span>
                </span>
            </div>
            <div class="status-row status-resources">
                <span class="status-stat" title="Conexión con el barrio">
                    <span class="stat-icon">${iconHTML('users', 16)}</span>
                    <span class="stat-value" data-stat="conexion"></span>
                </span>
                <span class="status-stat" title="Tu dignidad">
                    <span class="stat-icon">${iconHTML('shield', 16)}</span>
                    <span class="stat-value" data-stat="dignidad"></span>
                </span>
                <span class="status-stat stat-llama" title="La llama colectiva">
                    <span class="stat-icon">${iconHTML('flame', 16)}</span>
                    <span class="stat-value" data-stat="llama"></span>
                </span>
            </div>
        `;
        // Cache element references for efficient updates
        statusElements = {
            dia: statusContainer.querySelector('[data-stat="dia"]'),
            energiaBar: statusContainer.querySelector('[data-stat="energia-bar"]'),
            conexion: statusContainer.querySelector('[data-stat="conexion"]'),
            dignidad: statusContainer.querySelector('[data-stat="dignidad"]'),
            llama: statusContainer.querySelector('[data-stat="llama"]')
        };
        lastStatusValues = {};
        refreshIcons();
    }

    function updateStatus() {
        if (!statusContainer) return;

        if (!gameStarted) {
            if (statusContainer.innerHTML !== '<span class="status-phase">CREACIÓN DE PERSONAJE</span>') {
                statusContainer.innerHTML = '<span class="status-phase">CREACIÓN DE PERSONAJE</span>';
                statusElements = null;
            }
            return;
        }

        // Initialize status bar structure if needed
        if (!statusElements) {
            initStatusBar();
        }

        let energia = 4, conexion = 5, laLlama = 3, dignidad = 5, diaActual = 1;

        try {
            energia = story.variablesState['energia'] ?? 4;
            conexion = story.variablesState['conexion'] ?? 5;
            laLlama = story.variablesState['llama'] ?? 3;
            dignidad = story.variablesState['dignidad'] ?? 5;
            diaActual = story.variablesState['dia_actual'] ?? 1;
        } catch (e) {}

        // Only update values that have changed (avoid unnecessary DOM writes)
        const diaNombre = DIAS[diaActual] || DIAS[1];
        if (lastStatusValues.dia !== diaNombre) {
            statusElements.dia.textContent = diaNombre;
            lastStatusValues.dia = diaNombre;
        }

        const energiaBar = '●'.repeat(energia) + '○'.repeat(Math.max(0, 5 - energia));
        if (lastStatusValues.energiaBar !== energiaBar) {
            statusElements.energiaBar.textContent = energiaBar;
            lastStatusValues.energiaBar = energiaBar;
        }

        if (lastStatusValues.conexion !== conexion) {
            statusElements.conexion.textContent = conexion;
            lastStatusValues.conexion = conexion;
        }

        if (lastStatusValues.dignidad !== dignidad) {
            statusElements.dignidad.textContent = dignidad;
            lastStatusValues.dignidad = dignidad;
        }

        if (lastStatusValues.llama !== laLlama) {
            statusElements.llama.textContent = laLlama;
            lastStatusValues.llama = laLlama;
        }
    }

    function onChoiceClick(event) {
        const choiceIndex = parseInt(event.target.dataset.choiceIndex, 10);
        story.ChooseChoiceIndex(choiceIndex);
        continueStory();
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
})();
