/**
 * Un Día Más - Game Engine (Updated for Design System Phase 4)
 */
const GameEngine = (function() {
    'use strict';

    // DOM Elements
    let storyContainer, choicesContainer, statusContainer;
    let dayDisplay, locDisplay, locationDeco;

    // Ink Story
    let story = null;

    // State
    let gameStarted = false;
    let contentQueue = [];
    let previousDice = { ultima_tirada: 0, ultimo_resultado: 0 };
    let detectedEnding = null;
    
    // Theme State
    let currentLoc = 'oficina'; // Default
    let currentAtmosphere = '';

    // Constants
    const DIAS = ['', 'LUNES', 'MARTES', 'MIÉRCOLES', 'JUEVES', 'VIERNES', 'SÁBADO', 'DOMINGO'];

    async function init() {
        storyContainer = document.getElementById('storyContainer');
        choicesContainer = document.getElementById('choicesContainer');
        statusContainer = document.getElementById('statusContainer');
        dayDisplay = document.getElementById('dayDisplay');
        locDisplay = document.getElementById('locDisplay');
        locationDeco = document.getElementById('locationDeco');

        // Show Game Header
        document.getElementById('gameHeader').style.display = 'flex';

        await ConfigManager.loadAll();

        if (typeof storyContent === 'undefined') {
            console.error('storyContent not found.');
            storyContainer.innerHTML = '<p class="error">Error: No se pudo cargar la historia.</p>';
            return;
        }

        story = new inkjs.Story(storyContent);

        NotificationSystem.init();
        StatsPanel.init(story, statusContainer); // Note: StatsPanel might need CSS adjustments
        RelationshipsPanel.init(story);
        PortraitSystem.init();
        SaveSystem.init(story, { onLoad: handleLoad });

        if (typeof EndingScreen !== 'undefined') await EndingScreen.loadConfig();
        if (typeof AccessibilityManager !== 'undefined') AccessibilityManager.init();
        if (typeof AudioSystem !== 'undefined') AudioSystem.init();
        if (typeof TextPresenter !== 'undefined') TextPresenter.init();

        saveCurrentState();
        
        // Initial Theme
        updateTheme('oficina');
        
        continueStory();
    }

    function saveCurrentState() {
        if (!story) return;
        try {
            previousDice = {
                ultima_tirada: story.variablesState['ultima_tirada'] ?? 0,
                ultimo_resultado: story.variablesState['ultimo_resultado'] ?? 0
            };
        } catch (e) { console.warn(e); }
    }

    function checkDiceRoll() {
        if (!ConfigManager.isFeatureEnabled('diceRolls')) return null;
        try {
            const currentTirada = story.variablesState['ultima_tirada'] ?? 0;
            const currentResultado = story.variablesState['ultimo_resultado'] ?? 0;
            if (currentTirada !== previousDice.ultima_tirada && currentTirada !== 0) {
                const diceData = { roll: currentTirada, result: currentResultado };
                if (typeof DecisionLog !== 'undefined') DecisionLog.logDice(currentTirada, currentResultado);
                previousDice = { ultima_tirada: currentTirada, ultimo_resultado: currentResultado };
                return diceData;
            }
            previousDice = { ultima_tirada: currentTirada, ultimo_resultado: currentResultado };
        } catch (e) {}
        return null;
    }

    function createDiceElement(roll, result, context) {
        const rollDiv = document.createElement('div');
        rollDiv.className = 'dice-area'; // New CSS class
        
        const resultInfo = ConfigManager.getDiceResult(result); // Legacy helper, might need mapping
        
        // Context Text
        let contextText = "";
        if (context === 'ventaja') contextText = " (CON VENTAJA)";
        else if (context === 'desventaja') contextText = " (CON DESVENTAJA)";

        // Dice HTML (Brutalist Style)
        let diceHtml = `
            <span class="dice-label">TIRADA DE DADOS${contextText}</span>
            <div class="dice-container">
                <div class="die">${roll}</div>
            </div>
        `;

        if (result !== 0) {
            diceHtml += `<div class="dice-result">${resultInfo.label}</div>`;
        }

        rollDiv.innerHTML = diceHtml;
        return rollDiv;
    }

    function checkStatChanges() {
        if (!gameStarted || !ConfigManager.isFeatureEnabled('statNotifications')) return;
        try {
            const stats = ConfigManager.getAllStats();
            for (const statId in stats) {
                const diff = StatsPanel.getStatDiff(statId);
                if (diff !== 0) {
                    const current = StatsPanel.getStatValue(statId);
                    NotificationSystem.showStatChange(statId, diff);
                    if (typeof DecisionLog !== 'undefined') DecisionLog.logStatChange(statId, current - diff, current);
                }
            }
        } catch (e) {}
    }

    /**
     * Update visual theme based on location tag
     */
    function updateTheme(locTag) {
        const loc = locTag.toLowerCase();
        currentLoc = loc;
        
        // Remove old theme classes
        document.body.classList.remove('theme-oficina', 'theme-calle', 'theme-casa', 'theme-olla');
        
        // Add new theme class
        document.body.classList.add(`theme-${loc}`);
        
        // Update HUD Text
        if (locDisplay) locDisplay.innerText = loc.toUpperCase();
        
        // Update Decoration (Optional)
        if (locationDeco) {
            let decoText = "";
            if (loc === 'oficina' || loc === 'laburo') decoText = "EXP: 2026-UY";
            else if (loc === 'calle' || loc === 'bondi') decoText = "ZONA: OBRAS";
            else if (loc === 'casa') decoText = "DÍA " + (story.variablesState['dia_actual'] || 1);
            else if (loc === 'olla') decoText = "TURNO: NOCHE";
            locationDeco.innerText = decoText;
        }
    }

    /**
     * Update atmosphere effects
     */
    function updateAtmosphere(effectTag) {
        const effect = effectTag.toLowerCase();
        
        // Clear previous effects? Maybe accumulate? For now, simplistic toggle.
        document.body.classList.remove('effect-humedad', 'effect-inercia');
        
        if (effect === 'humedad') document.body.classList.add('effect-humedad');
        if (effect === 'inercia') document.body.classList.add('effect-inercia');
        if (effect === 'clear') { /* Cleared above */ }
    }

    function continueStory() {
        choicesContainer.innerHTML = '';
        contentQueue = [];
        const maxParagraphs = ConfigManager.get('ui.layout.maxParagraphsBeforePause', 4);
        let paragraphCount = 0;
        let currentBatch = [];

        while (story.canContinue) {
            const text = story.Continue();
            const tags = story.currentTags || [];

            const diceData = checkDiceRoll();
            if (diceData) {
                currentBatch.push({ type: 'dice', roll: diceData.roll, result: diceData.result, context: diceData.context || null });
            }

            PortraitSystem.processTags(tags);

            let hasHeader = false;
            for (const tag of tags) {
                // TAG PROCESSING
                if (tag.startsWith('LOC:')) {
                    updateTheme(tag.split(':')[1].trim());
                } else if (tag.startsWith('AMBIENTE:')) {
                    updateAtmosphere(tag.split(':')[1].trim());
                } else if (tag.startsWith('AUDIO:')) {
                    if (typeof AudioSystem !== 'undefined') AudioSystem.processTag(tag);
                } else if (tag === 'DADOS:VENTAJA' || tag === 'DADOS:DESVENTAJA') {
                    if (diceData) diceData.context = tag === 'DADOS:VENTAJA' ? 'ventaja' : 'desventaja';
                } else if (tag.startsWith('IDEA DISPONIBLE:') || tag === 'IDEA') {
                    currentBatch.push({ type: 'idea', content: tag, tags: tags });
                } else if (tag.startsWith('MIENTRAS')) {
                    currentBatch.push({ type: 'fragmento', content: tag, tags: tags });
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
                    
                    // Update Day Display
                    if (dayDisplay) dayDisplay.innerText = `DÍA ${story.variablesState['dia_actual']} / ${tag}`;

                    if (typeof AudioSystem !== 'undefined') AudioSystem.setDayBGM(tag.toLowerCase());
                } else if (tag.startsWith('ENDING:')) {
                    detectedEnding = tag.substring(7).trim();
                } else if (tag === 'PAUSA' || tag === 'CONTINUO') {
                    if (currentBatch.length > 0) {
                        const lastItem = currentBatch[currentBatch.length - 1];
                        if (!lastItem.tags) lastItem.tags = [];
                        lastItem.tags.push(tag);
                    }
                } else if (!tag.startsWith('PORTRAIT') && !tag.startsWith('HIDE') && !tag.startsWith('EXPRESSION') && !tag.startsWith('VOZ:')) {
                    // Standard header detection
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
                // Pass tags to item for TextPresenter to handle voices
                currentBatch.push({ type: 'text', content: text, tags: tags });
                paragraphCount++;

                if (ConfigManager.isFeatureEnabled('contentBatching') && paragraphCount >= maxParagraphs && !hasHeader) {
                    contentQueue.push([...currentBatch]);
                    currentBatch = [];
                    paragraphCount = 0;
                }
            }
        }

        if (currentBatch.length > 0) contentQueue.push(currentBatch);

        checkStatChanges();
        saveCurrentState();
        StatsPanel.update();
        
        // Auto-check Inercia effect based on stat
        try {
            const inercia = story.variablesState['inercia'] ?? 0;
            if (inercia >= 8) document.body.classList.add('effect-inercia');
            else if (currentAtmosphere !== 'inercia') document.body.classList.remove('effect-inercia');
        } catch(e) {}

        storyContainer.innerHTML = '';
        showNextBatch();
    }

    function showNextBatch() {
        if (contentQueue.length === 0) {
            showChoices();
            return;
        }
        const batch = contentQueue.shift();
        const isNewScene = batch.length > 0 && batch[0].type === 'header';

        if (isNewScene) {
            const separator = document.createElement('hr');
            separator.className = 'scene-separator';
            storyContainer.appendChild(separator);
        }

        const items = [];
        for (const item of batch) {
            if (item.type === 'dice') {
                const rollDiv = createDiceElement(item.roll, item.result, item.context);
                storyContainer.appendChild(rollDiv);
            } else {
                items.push(item);
            }
        }

        if (typeof TextPresenter !== 'undefined' && items.length > 0) {
            TextPresenter.present(storyContainer, items, () => finishBatch());
        } else {
            // Fallback rendering
            for (const item of items) {
                const el = document.createElement(item.type === 'header' ? 'h1' : 'div');
                el.className = item.type === 'header' ? 'story-header' : 'story-text';
                // Sanitize content if validator available
                const safeContent = typeof SecurityValidator !== 'undefined' 
                    ? SecurityValidator.sanitizeHTML(item.content) 
                    : item.content;
                el.innerHTML = safeContent;
                storyContainer.appendChild(el);
            }
            finishBatch();
        }
        window.scrollTo(0, 0);
    }

    function finishBatch() {
        checkStatChanges();
        saveCurrentState();
        StatsPanel.update();
        if (contentQueue.length > 0) showContinueButton();
        else showChoices();
    }

    function showContinueButton() {
        const button = ChoiceParser.buildContinueButton('normal', () => {
            choicesContainer.innerHTML = '';
            showNextBatch();
            storyContainer.lastElementChild?.scrollIntoView({ behavior: 'smooth', block: 'start' });
        });
        choicesContainer.appendChild(button);
    }

    function extractStoryVariables() {
        const vars = {};
        const keys = ['energia', 'conexion', 'dignidad', 'llama', 'inercia', 'vinculo', 'dia_actual'];
        for (const key of keys) {
            try { vars[key] = story.variablesState[key]; } catch (e) {}
        }
        return vars;
    }

    function showChoices() {
        choicesContainer.innerHTML = '';
        if (story.currentChoices.length === 0) {
            if (typeof AccessibilityManager !== 'undefined') AccessibilityManager.announceGameEnd();
            if (detectedEnding && typeof EndingScreen !== 'undefined') {
                setTimeout(() => EndingScreen.show(detectedEnding, extractStoryVariables()), 1500);
            }
            return;
        }

        for (let i = 0; i < story.currentChoices.length; i++) {
            const choice = story.currentChoices[i];
            const button = ChoiceParser.buildButton(choice, i, story, onChoiceClick);
            choicesContainer.appendChild(button);
        }
        
        if (typeof AccessibilityManager !== 'undefined') AccessibilityManager.enhanceChoices(choicesContainer);
        refreshIcons(choicesContainer);
    }

    function onChoiceClick(event) {
        const button = event.target.closest('button');
        if (!button) return;
        const choiceIndex = parseInt(button.dataset.choiceIndex, 10);
        if (typeof DecisionLog !== 'undefined' && story.currentChoices[choiceIndex]) {
            DecisionLog.logChoice(story.currentChoices[choiceIndex].text);
        }
        story.ChooseChoiceIndex(choiceIndex);
        continueStory();
    }

    function handleLoad(slotId, saveData) {
        gameStarted = true;
        StatsPanel.setGameStarted(true);
        saveCurrentState();
        continueStory();
    }

    function refresh() {
        saveCurrentState();
        StatsPanel.update();
        continueStory();
    }

    function refreshIcons(container) {
        if (typeof lucide !== 'undefined') {
            lucide.createIcons({ root: container || document });
        }
    }

    function getStory() { return story; }

    return { init, continueStory, refresh, getStory, refreshIcons };
})();

window.GameEngine = GameEngine;