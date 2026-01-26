/**
 * Start Screen Module
 * Handles the main menu and spoiler-free manual
 */
const StartScreen = (function() {
    'use strict';

    let startScreen = null;
    let gameContainer = null;

    /**
     * Initialize module
     */
    function init() {
        startScreen = document.getElementById('startScreen');
        gameContainer = document.getElementById('game');

        // Refresh icons
        if (typeof lucide !== 'undefined') {
            lucide.createIcons();
        }

        // Check if there are saved games to show/hide continue button
        updateContinueButton();
    }

    /**
     * Update continue button visibility based on saved games
     */
    function updateContinueButton() {
        const continueBtn = document.querySelector('.start-btn[onclick*="showContinue"]');
        if (!continueBtn) return;

        // Check if there are any saves
        let hasSaves = false;
        for (let i = 1; i <= 3; i++) {
            if (localStorage.getItem(`undiamas_save_${i}`)) {
                hasSaves = true;
                break;
            }
        }

        continueBtn.style.display = hasSaves ? 'flex' : 'none';
    }

    /**
     * Start a new game
     */
    function startGame() {
        if (startScreen) startScreen.style.display = 'none';
        if (gameContainer) gameContainer.style.display = 'block';

        // Initialize the game engine
        GameEngine.init();
    }

    /**
     * Show continue/load dialog
     */
    function showContinue() {
        if (typeof SaveSystem !== 'undefined') {
            SaveSystem.showModal();
        }
    }

    /**
     * Show spoiler-free manual for new players
     */
    function showManual() {
        const modal = document.createElement('div');
        modal.className = 'modal-overlay';
        modal.id = 'manualModal';
        modal.innerHTML = `
            <div class="modal-content manual-modal">
                <div class="modal-header">
                    <h2><i data-lucide="book-open"></i> Cómo jugar</h2>
                    <button class="modal-close" onclick="StartScreen.closeManual()">
                        <i data-lucide="x" style="width:20px;height:20px;"></i>
                    </button>
                </div>
                <div class="modal-body manual-body">

                    <section class="manual-section">
                        <h3><i data-lucide="info"></i> ¿De qué va?</h3>
                        <p>Sos un trabajador en un barrio de Montevideo. Una semana que empieza como todas... pero no lo es.</p>
                        <p>Tus decisiones definen quién sos y cómo te relacionás con el barrio.</p>
                    </section>

                    <section class="manual-section">
                        <h3><i data-lucide="mouse-pointer-click"></i> Cómo se juega</h3>
                        <ul>
                            <li>Leés la historia y elegís entre las opciones</li>
                            <li>Tus elecciones tienen consecuencias</li>
                            <li>No hay respuestas correctas o incorrectas</li>
                            <li><strong>Teclas:</strong> Espacio/Enter para continuar, 1-9 para elegir</li>
                        </ul>
                    </section>

                    <section class="manual-section">
                        <h3><i data-lucide="bar-chart-2"></i> Recursos</h3>
                        <p>En el header vas a ver tus recursos. Sin spoilers:</p>
                        <ul>
                            <li><span class="stat-color energia">Energía</span> - Lo que podés hacer hoy</li>
                            <li><span class="stat-color conexion">Conexión</span> - Tu lugar en el barrio</li>
                            <li><span class="stat-color llama">La Llama</span> - Algo que se comparte</li>
                            <li><span class="stat-color dignidad">Dignidad</span> - Tu valor propio</li>
                            <li><span class="stat-color salud">Salud Mental</span> - Cómo estás</li>
                        </ul>
                    </section>

                    <section class="manual-section">
                        <h3><i data-lucide="dices"></i> Dados</h3>
                        <p>A veces el azar decide. Vas a ver tiradas de dados con resultados:</p>
                        <div class="dice-preview">
                            <span class="dice-ex dice-crit">6 = Éxito crítico</span>
                            <span class="dice-ex dice-ok">4-5 = Éxito</span>
                            <span class="dice-ex dice-fail">2-3 = Fallo</span>
                            <span class="dice-ex dice-fumble">1 = Fallo crítico</span>
                        </div>
                    </section>

                    <section class="manual-section">
                        <h3><i data-lucide="save"></i> Guardar</h3>
                        <p>Podés guardar en cualquier momento con el ícono <i data-lucide="save" style="width:14px;height:14px;vertical-align:middle;"></i> en el header.</p>
                    </section>

                    <section class="manual-section">
                        <h3><i data-lucide="map-pin"></i> Vocabulario</h3>
                        <p>El juego usa palabras uruguayas:</p>
                        <ul>
                            <li><strong>Bondi</strong> - Autobús</li>
                            <li><strong>Laburo</strong> - Trabajo</li>
                            <li><strong>Olla popular</strong> - Comedor comunitario</li>
                            <li><strong>Pibe/a</strong> - Chico/a</li>
                        </ul>
                    </section>

                    <section class="manual-section manual-tip">
                        <p><strong>Consejo:</strong> No hay finales buenos o malos. Cada historia es válida.</p>
                    </section>

                </div>
            </div>
        `;

        document.body.appendChild(modal);

        // Accessibility: trap focus in modal
        if (typeof AccessibilityManager !== 'undefined') {
            AccessibilityManager.trapFocus(modal);
        }

        // Close on overlay click
        modal.onclick = (e) => {
            if (e.target === modal) closeManual();
        };

        if (typeof lucide !== 'undefined') {
            lucide.createIcons();
        }
    }

    /**
     * Close manual modal
     */
    function closeManual() {
        const modal = document.getElementById('manualModal');
        if (modal) {
            if (typeof AccessibilityManager !== 'undefined') {
                AccessibilityManager.releaseFocus(modal);
            }
            modal.remove();
        }
    }

    /**
     * Show start screen (for returning from game)
     */
    function show() {
        if (startScreen) startScreen.style.display = 'flex';
        if (gameContainer) gameContainer.style.display = 'none';
        updateContinueButton();
    }

    /**
     * Hide start screen
     */
    function hide() {
        if (startScreen) startScreen.style.display = 'none';
        if (gameContainer) gameContainer.style.display = 'block';
    }

    // Public API
    return {
        init,
        startGame,
        showContinue,
        showManual,
        closeManual,
        show,
        hide
    };
})();

// Initialize when DOM is ready
document.addEventListener('DOMContentLoaded', () => {
    StartScreen.init();
});
