/**
 * Un Día Más - Game Engine
 * Orchestrates all modules for the narrative game experience
 *
 * Modules used:
 * - ConfigManager: Configuration loading and access
 * - StatsPanel: Stats display and threshold effects
 * - RelationshipsPanel: NPC relationships
 * - SaveSystem: Save/Load functionality
 * - PortraitSystem: Character portraits
 * - NotificationSystem: Visual notifications
 * - ChoiceParser: Choice tag parsing
 */
const GameEngine = (function() {
    'use strict';

    // DOM Elements
    let storyContainer, choicesContainer, statusContainer;

    // Ink Story
    let story = null;

    // State
    let gameStarted = false;
    let contentQueue = [];
    let previousStats = {};
    let previousDice = { ultima_tirada: 0, ultimo_resultado: 0 };

    // Constants
    const DIAS = ['', 'LUNES', 'MARTES', 'MIÉRCOLES', 'JUEVES', 'VIERNES', 'SÁBADO', 'DOMINGO'];

    /**
     * Initialize the game
     */
    async function init() {
        // Get DOM elements
        storyContainer = document.getElementById('storyContainer');
        choicesContainer = document.getElementById('choicesContainer');
        statusContainer = document.getElementById('statusContainer');

        // Load configuration
        await ConfigManager.loadAll();

        // Verify story content exists
        if (typeof storyContent === 'undefined') {
            console.error('storyContent not found. Make sure un_dia_mas.js is loaded.');
            storyContainer.innerHTML = '<p class="error">Error: No se pudo cargar la historia.</p>';
            return;
        }

        // Create Ink story
        story = new inkjs.Story(storyContent);

        // Initialize modules
        NotificationSystem.init();
        StatsPanel.init(story, statusContainer);
        RelationshipsPanel.init(story);
        PortraitSystem.init();
        SaveSystem.init(story, {
            onLoad: handleLoad
        });

        // Save initial state
        saveCurrentState();

        // Start the story
        continueStory();
    }

    /**
     * Save current stat values for change detection
     */
    function saveCurrentState() {
        if (!story) return;

        try {
            const stats = ConfigManager.getAllStats();
            for (const statId in stats) {
                previousStats[statId] = story.variablesState[statId] ?? stats[statId].default;
            }

            previousDice = {
                ultima_tirada: story.variablesState['ultima_tirada'] ?? 0,
                ultimo_resultado: story.variablesState['ultimo_resultado'] ?? 0
            };
        } catch (e) {
            console.warn('Error saving state:', e);
        }
    }

    /**
     * Check for dice roll changes and return dice data if found
     * @returns {object|null} Dice roll data or null
     */
    function checkDiceRoll() {
        if (!ConfigManager.isFeatureEnabled('diceRolls')) return null;

        try {
            const currentTirada = story.variablesState['ultima_tirada'] ?? 0;
            const currentResultado = story.variablesState['ultimo_resultado'] ?? 0;

            if (currentTirada !== previousDice.ultima_tirada && currentTirada !== 0) {
                const diceData = { roll: currentTirada, result: currentResultado };

                // Log the dice roll
                if (typeof DecisionLog !== 'undefined') {
                    DecisionLog.logDice(currentTirada, currentResultado);
                }

                previousDice = {
                    ultima_tirada: currentTirada,
                    ultimo_resultado: currentResultado
                };

                return diceData;
            }

            previousDice = {
                ultima_tirada: currentTirada,
                ultimo_resultado: currentResultado
            };
        } catch (e) {
            console.warn('Error checking dice roll:', e);
        }
        return null;
    }

    /**
     * Create dice roll element
     * @param {number} roll - Dice value
     * @param {number} result - Result code (0 = simple roll, 1/-1/2 = chequeo result)
     * @returns {HTMLElement}
     */
    function createDiceElement(roll, result) {
        const rollDiv = document.createElement('div');

        // For simple rolls (result=0), show just the number
        if (result === 0) {
            rollDiv.className = 'dice-roll-box dice-simple';
            rollDiv.innerHTML = `
                <div class="dice-roll-inline">
                    <span class="dice-icon">${iconHTML('dices', 20)}</span>
                    <span class="dice-value-inline">${roll}</span>
                    <span class="dice-label-inline">Tirada: ${roll}</span>
                </div>
            `;
        } else {
            // For chequeo results, show full card
            const resultInfo = ConfigManager.getDiceResult(result);
            const description = resultInfo.description || '';

            rollDiv.className = `dice-roll-box ${resultInfo.class}`;
            rollDiv.innerHTML = `
                <div class="dice-roll-header">
                    <span class="dice-icon">${iconHTML('dices', 28)}</span>
                    <span class="dice-title">TIRADA DE DADOS</span>
                </div>
                <div class="dice-roll-result">
                    <span class="dice-value">${roll}</span>
                </div>
                <div class="dice-roll-label">${resultInfo.label}</div>
                <div class="dice-roll-desc">${description}</div>
            `;
        }

        refreshIcons();
        return rollDiv;
    }

    /**
     * Check for stat changes and show notifications
     */
    function checkStatChanges() {
        if (!gameStarted || !ConfigManager.isFeatureEnabled('statNotifications')) return;

        try {
            const stats = ConfigManager.getAllStats();

            for (const statId in stats) {
                const current = story.variablesState[statId] ?? stats[statId].default;
                const previous = previousStats[statId] ?? current;
                const diff = current - previous;

                if (diff !== 0) {
                    NotificationSystem.showStatChange(statId, diff);
                    // Log the stat change
                    if (typeof DecisionLog !== 'undefined') {
                        DecisionLog.logStatChange(statId, previous, current);
                    }
                }
            }
        } catch (e) {
            console.warn('Error checking stat changes:', e);
        }
    }

    /**
     * Continue the story and render content
     */
    function continueStory() {
        choicesContainer.innerHTML = '';
        contentQueue = [];

        const maxParagraphs = ConfigManager.get('ui.layout.maxParagraphsBeforePause', 4);
        let paragraphCount = 0;
        let currentBatch = [];

        while (story.canContinue) {
            const text = story.Continue();
            const tags = story.currentTags || [];

            // Check for dice roll and add to batch if found
            const diceData = checkDiceRoll();
            if (diceData) {
                currentBatch.push({ type: 'dice', roll: diceData.roll, result: diceData.result });
            }

            // Process portrait tags
            PortraitSystem.processTags(tags);

            // Process other tags
            let hasHeader = false;
            for (const tag of tags) {
                if (tag.startsWith('IDEA DISPONIBLE:') || tag === 'IDEA') {
                    currentBatch.push({ type: 'idea', content: tag });
                } else if (tag.startsWith('MIENTRAS')) {
                    currentBatch.push({ type: 'fragmento', content: tag });
                } else if (DIAS.includes(tag)) {
                    hasHeader = true;
                    if (currentBatch.length > 0) {
                        contentQueue.push([...currentBatch]);
                        currentBatch = [];
                        paragraphCount = 0;
                    }
                    currentBatch.push({ type: 'header', content: tag });
                    gameStarted = true;
                    StatsPanel.setGameStarted(true);
                } else if (!tag.startsWith('PORTRAIT') && !tag.startsWith('HIDE') && !tag.startsWith('EXPRESSION') && !tag.startsWith('SPEAKING')) {
                    // Other header-like tags
                    if (tag.length > 0 && tag === tag.toUpperCase() && !tag.includes(':')) {
                        hasHeader = true;
                        if (currentBatch.length > 0) {
                            contentQueue.push([...currentBatch]);
                            currentBatch = [];
                            paragraphCount = 0;
                        }
                        currentBatch.push({ type: 'header', content: tag });
                    }
                }
            }

            if (text.trim()) {
                currentBatch.push({ type: 'text', content: text });
                paragraphCount++;

                if (ConfigManager.isFeatureEnabled('contentBatching') &&
                    paragraphCount >= maxParagraphs && !hasHeader) {
                    contentQueue.push([...currentBatch]);
                    currentBatch = [];
                    paragraphCount = 0;
                }
            }
        }

        if (currentBatch.length > 0) {
            contentQueue.push(currentBatch);
        }

        // Update stats and state
        checkStatChanges();
        saveCurrentState();
        StatsPanel.update();

        // Clear and show content
        storyContainer.innerHTML = '';
        showNextBatch();
    }

    /**
     * Show the next batch of content
     */
    function showNextBatch() {
        if (contentQueue.length === 0) {
            showChoices();
            return;
        }

        const batch = contentQueue.shift();

        // Check if we're appending to existing content (not a fresh scene)
        const isAppending = storyContainer.children.length > 0 &&
                           !(batch.length > 0 && batch[0].type === 'header');

        // If batch starts with a header, clear the screen for fresh start
        if (batch.length > 0 && batch[0].type === 'header') {
            storyContainer.innerHTML = '';
        }

        for (const item of batch) {
            if (item.type === 'dice') {
                // Render dice roll
                const rollDiv = createDiceElement(item.roll, item.result);
                storyContainer.appendChild(rollDiv);
                continue;
            }

            const el = document.createElement(item.type === 'header' ? 'h1' : 'div');

            switch (item.type) {
                case 'header':
                    el.textContent = item.content;
                    el.className = 'story-header';
                    break;
                case 'text':
                    el.innerHTML = item.content;
                    // Add appended-text class only when continuing, not on fresh scenes
                    el.className = isAppending ? 'story-text appended-text' : 'story-text';
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

        // Check for changes after content
        checkStatChanges();
        saveCurrentState();
        StatsPanel.update();

        if (contentQueue.length > 0) {
            showContinueButton();
        } else {
            showChoices();
        }

        window.scrollTo(0, 0);
    }

    /**
     * Show continue button
     */
    function showContinueButton() {
        const button = ChoiceParser.buildContinueButton('normal', () => {
            choicesContainer.innerHTML = '';
            showNextBatch();
            storyContainer.lastElementChild?.scrollIntoView({ behavior: 'smooth', block: 'start' });
        });

        choicesContainer.appendChild(button);
    }

    /**
     * Show choices
     */
    function showChoices() {
        choicesContainer.innerHTML = '';

        if (story.currentChoices.length === 0) {
            // End of story
            return;
        }

        for (let i = 0; i < story.currentChoices.length; i++) {
            const choice = story.currentChoices[i];
            const button = ChoiceParser.buildButton(choice, i, story, onChoiceClick);
            choicesContainer.appendChild(button);
        }

        refreshIcons();
    }

    /**
     * Handle choice click
     */
    function onChoiceClick(event) {
        const button = event.target.closest('button');
        if (!button) return;

        const choiceIndex = parseInt(button.dataset.choiceIndex, 10);

        // Log the choice before making it
        if (typeof DecisionLog !== 'undefined' && story.currentChoices[choiceIndex]) {
            DecisionLog.logChoice(story.currentChoices[choiceIndex].text);
        }

        story.ChooseChoiceIndex(choiceIndex);
        continueStory();
    }

    /**
     * Handle game load
     */
    function handleLoad(slotId, saveData) {
        gameStarted = true;
        StatsPanel.setGameStarted(true);
        saveCurrentState();
        continueStory();
    }

    /**
     * Refresh the game (after load)
     */
    function refresh() {
        saveCurrentState();
        StatsPanel.update();
        continueStory();
    }

    /**
     * Create icon HTML
     */
    function iconHTML(name, size = 16) {
        return `<i data-lucide="${name}" style="width:${size}px;height:${size}px;"></i>`;
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
     * Get the story instance
     */
    function getStory() {
        return story;
    }

    // Public API
    return {
        init,
        continueStory,
        refresh,
        getStory,
        refreshIcons
    };
})();

// Don't auto-init - StartScreen.startGame() calls GameEngine.init()
// Expose globally for module access
window.GameEngine = GameEngine;
