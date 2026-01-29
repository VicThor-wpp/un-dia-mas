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
 * - AudioSystem: Background music and sound effects (optional)
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
    let previousDice = { ultima_tirada: 0, ultimo_resultado: 0 };
    let detectedEnding = null;

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

        // Initialize ending screen
        if (typeof EndingScreen !== 'undefined') {
            await EndingScreen.loadConfig();
        }

        // Initialize accessibility
        if (typeof AccessibilityManager !== 'undefined') {
            AccessibilityManager.init();
        }

        // Initialize audio system
        if (typeof AudioSystem !== 'undefined') {
            AudioSystem.init();
        }

        // Initialize text presenter
        if (typeof TextPresenter !== 'undefined') {
            TextPresenter.init();
        }

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
    function createDiceElement(roll, result, context) {
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

            const contextClass = context ? `dice-${context}` : '';
            const contextLabel = context === 'ventaja' ? ' (con ventaja)' : context === 'desventaja' ? ' (con desventaja)' : '';
            rollDiv.className = `dice-roll-box ${resultInfo.class} ${contextClass}`;
            rollDiv.innerHTML = `
                <div class="dice-roll-header">
                    <span class="dice-icon">${iconHTML('dices', 28)}</span>
                    <span class="dice-title">TIRADA DE DADOS${contextLabel}</span>
                </div>
                <div class="dice-roll-result">
                    <span class="dice-value">${roll}</span>
                </div>
                <div class="dice-roll-label">${resultInfo.label}</div>
                <div class="dice-roll-desc">${description}</div>
            `;
        }

        refreshIcons(rollDiv);
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
                const diff = StatsPanel.getStatDiff(statId);

                if (diff !== 0) {
                    const current = StatsPanel.getStatValue(statId);
                    NotificationSystem.showStatChange(statId, diff);
                    // Log the stat change
                    if (typeof DecisionLog !== 'undefined') {
                        DecisionLog.logStatChange(statId, current - diff, current);
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
                currentBatch.push({ type: 'dice', roll: diceData.roll, result: diceData.result, context: diceData.context || null });
            }

            // Process portrait tags
            PortraitSystem.processTags(tags);

            // Process other tags
            let hasHeader = false;
            for (const tag of tags) {
                // Handle audio tags
                if (tag.startsWith('AUDIO:')) {
                    if (typeof AudioSystem !== 'undefined') {
                        AudioSystem.processTag(tag);
                    }
                } else if (tag === 'DADOS:VENTAJA' || tag === 'DADOS:DESVENTAJA') {
                    // Store dice context for next dice roll display
                    if (diceData) {
                        diceData.context = tag === 'DADOS:VENTAJA' ? 'ventaja' : 'desventaja';
                    }
                } else if (tag.startsWith('IDEA DISPONIBLE:') || tag === 'IDEA') {
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
                    // Update BGM for the new day
                    if (typeof AudioSystem !== 'undefined') {
                        AudioSystem.setDayBGM(tag.toLowerCase());
                    }
                } else if (tag.startsWith('ENDING:')) {
                    detectedEnding = tag.substring(7).trim();
                } else if (tag === 'PAUSA' || tag === 'CONTINUO') {
                    // Store for TextPresenter
                    if (currentBatch.length > 0) {
                        const lastItem = currentBatch[currentBatch.length - 1];
                        if (!lastItem.tags) lastItem.tags = [];
                        lastItem.tags.push(tag);
                    }
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

        // Check if batch starts with a header (fresh scene)
        const isNewScene = batch.length > 0 && batch[0].type === 'header';

        if (isNewScene) {
            storyContainer.innerHTML = '';
        }

        // Prepare items for TextPresenter
        const items = [];
        for (const item of batch) {
            if (item.type === 'dice') {
                // Render dice immediately (special element)
                const rollDiv = createDiceElement(item.roll, item.result, item.context);
                storyContainer.appendChild(rollDiv);
            } else {
                // Queue for animated presentation
                items.push(item);
            }
        }

        // Use TextPresenter if available, otherwise fallback to direct render
        if (typeof TextPresenter !== 'undefined' && items.length > 0) {
            TextPresenter.present(storyContainer, items, () => {
                finishBatch();
            });
        } else {
            // Fallback: render directly (old behavior)
            for (const item of items) {
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
            finishBatch();
        }

        window.scrollTo(0, 0);
    }

    /**
     * Finish batch presentation
     */
    function finishBatch() {
        // Check for changes after content
        checkStatChanges();
        saveCurrentState();
        StatsPanel.update();

        if (contentQueue.length > 0) {
            showContinueButton();
        } else {
            showChoices();
        }
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
     * Extract key story variables for the ending screen
     * @returns {object}
     */
    function extractStoryVariables() {
        const vars = {};
        const keys = [
            'energia', 'conexion', 'dignidad', 'llama', 'inercia',
            'sofia_relacion', 'elena_relacion', 'diego_relacion',
            'marcos_relacion', 'juan_relacion', 'ixchel_relacion',
            'vinculo', 'dia_actual', 'tiene_laburo', 'pequenas_victorias'
        ];
        for (const key of keys) {
            try {
                vars[key] = story.variablesState[key];
            } catch (e) {
                // Variable may not exist
            }
        }
        return vars;
    }

    /**
     * Show choices
     */
    function showChoices() {
        choicesContainer.innerHTML = '';

        if (story.currentChoices.length === 0) {
            // End of story
            // Accessibility: announce game end
            if (typeof AccessibilityManager !== 'undefined') {
                AccessibilityManager.announceGameEnd();
            }

            // Show ending screen if an ending was detected
            if (detectedEnding && typeof EndingScreen !== 'undefined') {
                const vars = extractStoryVariables();
                // Small delay to let final text render
                setTimeout(function() {
                    EndingScreen.show(detectedEnding, vars);
                }, 1500);
            }
            return;
        }

        for (let i = 0; i < story.currentChoices.length; i++) {
            const choice = story.currentChoices[i];
            const button = ChoiceParser.buildButton(choice, i, story, onChoiceClick);
            choicesContainer.appendChild(button);
        }

        // Accessibility: enhance choices
        if (typeof AccessibilityManager !== 'undefined') {
            AccessibilityManager.enhanceChoices(choicesContainer);
        }

        refreshIcons(choicesContainer);
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
    function refreshIcons(container) {
        if (typeof lucide !== 'undefined') {
            if (container) {
                lucide.createIcons({ root: container });
            } else {
                lucide.createIcons();
            }
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
