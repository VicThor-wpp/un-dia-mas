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
                <div class="modal-body manual-body" id="manualBody">
                    <nav class="manual-nav">
                        <button class="manual-nav-dot active" data-section="0" title="¿De qué va?">1</button>
                        <button class="manual-nav-dot" data-section="1" title="Cómo se juega">2</button>
                        <button class="manual-nav-dot" data-section="2" title="Recursos">3</button>
                        <button class="manual-nav-dot" data-section="3" title="Dados">4</button>
                        <button class="manual-nav-dot" data-section="4" title="Guardar">5</button>
                        <button class="manual-nav-dot" data-section="5" title="Importante">6</button>
                    </nav>

                    <section class="manual-section" id="manual-section-0">
                        <h3><i data-lucide="info"></i> ¿De qué va?</h3>
                        <p>Sos un trabajador precario en un barrio de Montevideo. Facturás como "independiente" - sin derechos, sin red. El miércoles te despiden.</p>
                        <p><strong>No es mala suerte. Es el sistema.</strong> ¿Te aislás o te conectás?</p>
                    </section>

                    <section class="manual-section" id="manual-section-1">
                        <h3><i data-lucide="mouse-pointer-click"></i> Cómo se juega</h3>
                        <ul>
                            <li>Leés la historia y elegís entre las opciones</li>
                            <li>Tus elecciones tienen consecuencias</li>
                            <li>No hay respuestas correctas o incorrectas</li>
                            <li><strong>Teclas:</strong> Espacio/Enter para continuar, 1-9 para elegir</li>
                        </ul>
                    </section>

                    <section class="manual-section" id="manual-section-2">
                        <h3><i data-lucide="bar-chart-2"></i> Recursos</h3>
                        <p>En el header vas a ver tus recursos:</p>
                        <ul>
                            <li><span class="stat-color energia">Energía</span> - Lo que podés hacer hoy</li>
                            <li><span class="stat-color conexion">Conexión</span> - Tu lugar en el tejido del barrio</li>
                            <li><span class="stat-color llama">La Llama</span> - La esperanza colectiva. Si se apaga, todo se vuelve gris.</li>
                            <li><span class="stat-color dignidad">Dignidad</span> - El sistema te la saca de a poco. Defendela.</li>
                            <li><span class="stat-color salud">Salud Mental</span> - Cómo estás aguantando</li>
                        </ul>
                    </section>

                    <section class="manual-section" id="manual-section-3">
                        <h3><i data-lucide="dices"></i> Dados</h3>
                        <p>A veces el azar decide. Vas a ver tiradas de dados con resultados:</p>
                        <div class="dice-preview">
                            <span class="dice-ex dice-crit">6 = Éxito crítico</span>
                            <span class="dice-ex dice-ok">4-5 = Éxito</span>
                            <span class="dice-ex dice-fail">2-3 = Fallo</span>
                            <span class="dice-ex dice-fumble">1 = Fallo crítico</span>
                        </div>
                    </section>

                    <section class="manual-section" id="manual-section-4">
                        <h3><i data-lucide="save"></i> Guardar</h3>
                        <p>Podés guardar en cualquier momento con el ícono <i data-lucide="save" style="width:14px;height:14px;vertical-align:middle;"></i> en el header.</p>
                    </section>

                    <section class="manual-section manual-tip" id="manual-section-5">
                        <p><strong>Importante:</strong> Este juego tiene una posición. La precariedad no es mala suerte, es diseño. El individualismo es una trampa. La organización colectiva funciona.</p>
                    </section>

                </div>
            </div>
        `;

        document.body.appendChild(modal);

        // Setup mini-nav functionality
        setupManualNav();

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
     * Setup manual navigation dots
     */
    function setupManualNav() {
        const body = document.getElementById('manualBody');
        const dots = document.querySelectorAll('.manual-nav-dot');
        const sections = document.querySelectorAll('.manual-section');

        // Click handlers for dots
        dots.forEach(dot => {
            dot.addEventListener('click', () => {
                const sectionIndex = dot.dataset.section;
                const section = document.getElementById(`manual-section-${sectionIndex}`);
                if (section) {
                    section.scrollIntoView({ behavior: 'smooth', block: 'start' });
                }
            });
        });

        // Scroll handler to update active dot
        body.addEventListener('scroll', () => {
            const scrollTop = body.scrollTop;
            let activeIndex = 0;

            sections.forEach((section, index) => {
                if (section.offsetTop - 50 <= scrollTop) {
                    activeIndex = index;
                }
            });

            dots.forEach((dot, index) => {
                dot.classList.toggle('active', index === activeIndex);
            });
        });
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
     * Show manifesto modal
     */
    function showManifesto() {
        const modal = document.createElement('div');
        modal.className = 'modal-overlay';
        modal.id = 'manifestoModal';
        modal.innerHTML = `
            <div class="modal-content manifesto-modal">
                <div class="modal-header">
                    <h2><i data-lucide="flame"></i> Manifiesto</h2>
                    <button class="modal-close" onclick="StartScreen.closeManifesto()">
                        <i data-lucide="x" style="width:20px;height:20px;"></i>
                    </button>
                </div>
                <div class="modal-body manifesto-body">
                    <p>Sabés que está todo podrido. Todas saben. Quinientos años de modernidad colonial y doscientos de promesas republicanas incumplidas produjeron esto: un mundo donde el despojo se llama desarrollo, la explotación se llama oportunidad, y la muerte lenta de los pueblos se llama progreso.</p>

                    <p>Saber no cambia nada. Ese es el truco más viejo del poder. Podés tener el análisis perfecto, la teoría correcta, el diagnóstico certero —nombrar la colonialidad del poder, la necropolítica, la acumulación por desposesión— y mañana igual madrugás, igual vas a trabajar, igual agachás la cabeza cuando toca. El conocimiento sin práctica es decoración.</p>

                    <p>El cinismo no es resistencia. Es la forma que toma la derrota cuando se disfraza de lucidez. "Ya sé que es una mierda pero qué voy a hacer" es el sentido común que el poder necesita reproducir. No les importa que sepas. Les importa que no actúes. La conciencia crítica sin organización es inofensiva; más que eso, es funcional.</p>

                    <p>No hay afuera. No hay pureza. Todas nacimos en esto, formadas por esto, manchadas por esto. Rivera Cusicanqui tiene razón: somos ch'ixi, mezcladas, contradictorias, habitando mundos antagónicos simultáneamente. Cualquier pretensión de exterioridad absoluta es una mentira —y una mentira peligrosa, porque quien se cree pura se autoriza cualquier cosa.</p>

                    <p>Pero hay grietas. Las hubo siempre. Antes del capital, durante el capital, a pesar del capital. Comunidades que sostienen formas de vida que no responden a la lógica de la ganancia. Redes de cuidado que no escalan porque no están hechas para escalar. Saberes y prácticas que la modernidad declaró muertos y que siguen ahí, tercos, respirando.</p>

                    <p>No son puras. No son ingenuas. Son personas que hacen lo que creen correcto y ponen el cuerpo ahí, todos los días. Que construyen poder popular sin esperar permiso, sin esperar el momento correcto, sin esperar que la teoría esté completa. Que organizan sabiendo que pueden perder, que probablemente van a perder, y que igual hay que hacerlo.</p>

                    <p>La izquierda de Estado fracasó. Las vanguardias iluminadas que iban a liberar al pueblo terminaron siendo nuevos patrones. La socialdemocracia administró la miseria y cuando vino el fascismo, lo dejó pasar. Lo que queda es lo que siempre estuvo: la organización desde abajo, el mandar obedeciendo, la comunalidad, el apoyo mutuo. No como programa de gobierno sino como forma de vida.</p>

                    <p>Freire tenía razón: nadie libera a nadie, nadie se libera sola. Nos liberamos en comunidad o no nos liberamos. Y esa liberación no es un evento futuro, es una práctica presente. Cada asamblea horizontal, cada olla común, cada red de cuidado, cada espacio recuperado es un pedazo de mundo nuevo funcionando dentro del viejo.</p>

                    <p class="manifesto-final"><strong>No importa lo que pensás. No importa lo que sentís. Importa lo que hacés. La praxis es el único lugar donde la palabra se vuelve verdad.</strong></p>
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
            if (e.target === modal) closeManifesto();
        };

        if (typeof lucide !== 'undefined') {
            lucide.createIcons();
        }
    }

    /**
     * Close manifesto modal
     */
    function closeManifesto() {
        const modal = document.getElementById('manifestoModal');
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
        showManifesto,
        closeManifesto,
        show,
        hide
    };
})();

// Initialize when DOM is ready
document.addEventListener('DOMContentLoaded', () => {
    StartScreen.init();
});
