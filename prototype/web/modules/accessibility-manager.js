/**
 * AccessibilityManager - ARIA labels, focus management, and screen reader support
 */
const AccessibilityManager = (function() {
    'use strict';

    let focusTrapElement = null;

    function init() {
        setupARIA();
        setupFocusManagement();
        setupScreenReaderAnnouncements();
    }

    /**
     * Set up ARIA attributes on key elements
     */
    function setupARIA() {
        // Main containers
        const game = document.getElementById('game');
        if (game) {
            game.setAttribute('role', 'main');
            game.setAttribute('aria-label', 'Área de juego');
        }

        const startScreen = document.getElementById('startScreen');
        if (startScreen) {
            startScreen.setAttribute('role', 'dialog');
            startScreen.setAttribute('aria-label', 'Pantalla de inicio');
        }

        const storyContainer = document.getElementById('storyContainer');
        if (storyContainer) {
            storyContainer.setAttribute('role', 'log');
            storyContainer.setAttribute('aria-live', 'polite');
            storyContainer.setAttribute('aria-label', 'Historia');
        }

        const choicesContainer = document.getElementById('choicesContainer');
        if (choicesContainer) {
            choicesContainer.setAttribute('role', 'navigation');
            choicesContainer.setAttribute('aria-label', 'Opciones');
        }

        const statusContainer = document.getElementById('statusContainer');
        if (statusContainer) {
            statusContainer.setAttribute('role', 'status');
            statusContainer.setAttribute('aria-live', 'polite');
            statusContainer.setAttribute('aria-label', 'Estado del juego');
        }

        // Start screen buttons
        const startButtons = document.querySelectorAll('.start-btn');
        startButtons.forEach(btn => {
            if (!btn.getAttribute('aria-label')) {
                btn.setAttribute('aria-label', btn.textContent.trim());
            }
        });
    }

    /**
     * Focus trap for modals
     */
    function trapFocus(element) {
        focusTrapElement = element;
        const focusable = getFocusableElements(element);
        if (focusable.length === 0) return;

        const first = focusable[0];
        const last = focusable[focusable.length - 1];

        function handleTab(e) {
            if (e.key !== 'Tab') return;

            if (e.shiftKey) {
                if (document.activeElement === first) {
                    e.preventDefault();
                    last.focus();
                }
            } else {
                if (document.activeElement === last) {
                    e.preventDefault();
                    first.focus();
                }
            }
        }

        element._focusTrapHandler = handleTab;
        element.addEventListener('keydown', handleTab);
        first.focus();
    }

    /**
     * Release focus trap
     */
    function releaseFocus(element) {
        if (element && element._focusTrapHandler) {
            element.removeEventListener('keydown', element._focusTrapHandler);
            delete element._focusTrapHandler;
        }
        focusTrapElement = null;
    }

    /**
     * Get all focusable elements within a container
     */
    function getFocusableElements(container) {
        return Array.from(container.querySelectorAll(
            'button:not([disabled]), [href], input:not([disabled]), select:not([disabled]), textarea:not([disabled]), [tabindex]:not([tabindex="-1"])'
        )).filter(el => {
            return el.offsetWidth > 0 || el.offsetHeight > 0;
        });
    }

    /**
     * Set up focus management
     */
    function setupFocusManagement() {
        // Watch for modal overlays and trap focus
        const observer = new MutationObserver((mutations) => {
            for (const mutation of mutations) {
                for (const node of mutation.addedNodes) {
                    if (node.nodeType === 1 && node.classList && node.classList.contains('modal-overlay')) {
                        trapFocus(node);
                        node.setAttribute('role', 'dialog');
                        node.setAttribute('aria-modal', 'true');
                    }
                }
                for (const node of mutation.removedNodes) {
                    if (node.nodeType === 1 && node.classList && node.classList.contains('modal-overlay')) {
                        releaseFocus(node);
                    }
                }
            }
        });

        observer.observe(document.body, { childList: true });
    }

    /**
     * Set up screen reader announcements
     */
    function setupScreenReaderAnnouncements() {
        // Create a live region for announcements
        let announcer = document.getElementById('sr-announcer');
        if (!announcer) {
            announcer = document.createElement('div');
            announcer.id = 'sr-announcer';
            announcer.setAttribute('role', 'status');
            announcer.setAttribute('aria-live', 'assertive');
            announcer.setAttribute('aria-atomic', 'true');
            announcer.className = 'sr-only';
            document.body.appendChild(announcer);
        }
    }

    /**
     * Announce a message to screen readers
     */
    function announce(message) {
        const announcer = document.getElementById('sr-announcer');
        if (announcer) {
            announcer.textContent = '';
            // Small delay to ensure announcement
            setTimeout(() => {
                announcer.textContent = message;
            }, 50);
        }
    }

    /**
     * Set up ARIA on choices when they appear
     */
    function enhanceChoices(choicesContainer) {
        const buttons = choicesContainer.querySelectorAll('button');
        buttons.forEach((btn, index) => {
            btn.setAttribute('aria-label', `Opción ${index + 1}: ${btn.textContent.trim()}`);
        });

        if (buttons.length > 0) {
            announce(`${buttons.length} opciones disponibles`);
        }
    }

    /**
     * Announce story content for screen readers
     */
    function announceStoryUpdate(text) {
        if (text && text.trim()) {
            announce(text.trim().substring(0, 200));
        }
    }

    /**
     * Focus the first available choice or the continue button
     */
    function focusFirstChoice() {
        const choices = document.getElementById('choicesContainer');
        if (choices) {
            const firstBtn = choices.querySelector('button');
            if (firstBtn) {
                firstBtn.focus();
            }
        }
    }

    /**
     * Mark the game as ended
     */
    function announceGameEnd() {
        announce('La historia ha terminado');
    }

    // Public API
    return {
        init,
        trapFocus,
        releaseFocus,
        announce,
        enhanceChoices,
        announceStoryUpdate,
        focusFirstChoice,
        announceGameEnd
    };
})();

if (typeof window !== 'undefined') {
    window.AccessibilityManager = AccessibilityManager;
}
