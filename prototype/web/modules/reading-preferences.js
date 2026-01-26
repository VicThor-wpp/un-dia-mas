/**
 * Reading Preferences Module
 * Handles typography, themes, and reading comfort settings
 */
const ReadingPreferences = (function() {
    'use strict';

    const STORAGE_KEY = 'undiamas_reading_prefs';

    const defaults = {
        theme: 'dark',           // dark, light, sepia, high-contrast
        fontSize: 'medium',      // small, medium, large, xlarge
        fontFamily: 'mono',      // mono, serif, sans, dyslexic
        lineHeight: 'normal',    // compact, normal, relaxed
        typewriter: false,       // typewriter effect
        typewriterSpeed: 30      // ms per character
    };

    let prefs = { ...defaults };
    let panel = null;

    /**
     * Initialize module
     */
    function init() {
        loadPrefs();
        applyPrefs();
        createSettingsButton();
        setupKeyboardNav();
        setupSwipeNav();
    }

    /**
     * Load preferences from localStorage
     */
    function loadPrefs() {
        try {
            const saved = localStorage.getItem(STORAGE_KEY);
            if (saved) {
                prefs = { ...defaults, ...JSON.parse(saved) };
            }
        } catch (e) {
            console.warn('Could not load reading preferences');
        }
    }

    /**
     * Save preferences to localStorage
     */
    function savePrefs() {
        try {
            localStorage.setItem(STORAGE_KEY, JSON.stringify(prefs));
        } catch (e) {
            console.warn('Could not save reading preferences');
        }
    }

    /**
     * Apply current preferences to document
     */
    function applyPrefs() {
        const body = document.body;

        // Remove old classes
        body.classList.remove('theme-dark', 'theme-light', 'theme-sepia', 'theme-high-contrast');
        body.classList.remove('font-small', 'font-medium', 'font-large', 'font-xlarge');
        body.classList.remove('font-mono', 'font-serif', 'font-sans', 'font-dyslexic');
        body.classList.remove('line-compact', 'line-normal', 'line-relaxed');

        // Apply new classes
        body.classList.add(`theme-${prefs.theme}`);
        body.classList.add(`font-${prefs.fontSize}`);
        body.classList.add(`font-${prefs.fontFamily}`);
        body.classList.add(`line-${prefs.lineHeight}`);

        if (prefs.typewriter) {
            body.classList.add('typewriter-enabled');
        } else {
            body.classList.remove('typewriter-enabled');
        }
    }

    /**
     * Create settings button in header
     */
    function createSettingsButton() {
        const actionsSection = document.querySelector('.actions-section');
        if (!actionsSection) return;

        const btn = document.createElement('button');
        btn.className = 'header-btn';
        btn.id = 'settingsBtn';
        btn.innerHTML = '<i data-lucide="settings" style="width:18px;height:18px;"></i>';
        btn.title = 'Preferencias de lectura';
        btn.onclick = togglePanel;

        actionsSection.appendChild(btn);

        if (typeof lucide !== 'undefined') {
            lucide.createIcons();
        }
    }

    /**
     * Toggle settings panel
     */
    function togglePanel() {
        if (panel) {
            closePanel();
        } else {
            openPanel();
        }
    }

    /**
     * Open settings panel
     */
    function openPanel() {
        panel = document.createElement('div');
        panel.className = 'modal-overlay';
        panel.innerHTML = `
            <div class="modal-content prefs-panel">
                <div class="modal-header">
                    <h2><i data-lucide="book-open"></i> Preferencias de lectura</h2>
                    <button class="modal-close" onclick="ReadingPreferences.closePanel()">
                        <i data-lucide="x" style="width:20px;height:20px;"></i>
                    </button>
                </div>
                <div class="modal-body">

                    <!-- Theme -->
                    <div class="pref-group">
                        <label class="pref-label">Tema</label>
                        <div class="pref-options theme-options">
                            <button class="pref-btn ${prefs.theme === 'dark' ? 'active' : ''}" data-theme="dark">
                                <i data-lucide="moon"></i> Oscuro
                            </button>
                            <button class="pref-btn ${prefs.theme === 'light' ? 'active' : ''}" data-theme="light">
                                <i data-lucide="sun"></i> Claro
                            </button>
                            <button class="pref-btn ${prefs.theme === 'sepia' ? 'active' : ''}" data-theme="sepia">
                                <i data-lucide="coffee"></i> Sepia
                            </button>
                            <button class="pref-btn ${prefs.theme === 'high-contrast' ? 'active' : ''}" data-theme="high-contrast">
                                <i data-lucide="contrast"></i> Alto contraste
                            </button>
                        </div>
                    </div>

                    <!-- Font Size -->
                    <div class="pref-group">
                        <label class="pref-label">Tamaño de texto</label>
                        <div class="pref-options">
                            <button class="pref-btn ${prefs.fontSize === 'small' ? 'active' : ''}" data-fontsize="small">A-</button>
                            <button class="pref-btn ${prefs.fontSize === 'medium' ? 'active' : ''}" data-fontsize="medium">A</button>
                            <button class="pref-btn ${prefs.fontSize === 'large' ? 'active' : ''}" data-fontsize="large">A+</button>
                            <button class="pref-btn ${prefs.fontSize === 'xlarge' ? 'active' : ''}" data-fontsize="xlarge">A++</button>
                        </div>
                    </div>

                    <!-- Font Family -->
                    <div class="pref-group">
                        <label class="pref-label">Tipografía</label>
                        <div class="pref-options">
                            <button class="pref-btn ${prefs.fontFamily === 'mono' ? 'active' : ''}" data-fontfamily="mono">Terminal</button>
                            <button class="pref-btn ${prefs.fontFamily === 'serif' ? 'active' : ''}" data-fontfamily="serif">Libro</button>
                            <button class="pref-btn ${prefs.fontFamily === 'sans' ? 'active' : ''}" data-fontfamily="sans">Simple</button>
                            <button class="pref-btn ${prefs.fontFamily === 'dyslexic' ? 'active' : ''}" data-fontfamily="dyslexic">Dislexia</button>
                        </div>
                    </div>

                    <!-- Line Height -->
                    <div class="pref-group">
                        <label class="pref-label">Espaciado de líneas</label>
                        <div class="pref-options">
                            <button class="pref-btn ${prefs.lineHeight === 'compact' ? 'active' : ''}" data-lineheight="compact">Compacto</button>
                            <button class="pref-btn ${prefs.lineHeight === 'normal' ? 'active' : ''}" data-lineheight="normal">Normal</button>
                            <button class="pref-btn ${prefs.lineHeight === 'relaxed' ? 'active' : ''}" data-lineheight="relaxed">Amplio</button>
                        </div>
                    </div>

                    <!-- Typewriter Effect -->
                    <div class="pref-group">
                        <label class="pref-label">Efecto máquina de escribir</label>
                        <div class="pref-options">
                            <button class="pref-btn ${!prefs.typewriter ? 'active' : ''}" data-typewriter="false">Desactivado</button>
                            <button class="pref-btn ${prefs.typewriter ? 'active' : ''}" data-typewriter="true">Activado</button>
                        </div>
                    </div>

                    <!-- Audio -->
                    <div class="pref-group">
                        <label class="pref-label">Audio</label>
                        <div class="pref-options">
                            <button class="pref-btn ${typeof AudioSystem !== 'undefined' && AudioSystem.isEnabled() ? 'active' : ''}" data-audio="on">Activado</button>
                            <button class="pref-btn ${typeof AudioSystem !== 'undefined' && !AudioSystem.isEnabled() ? 'active' : ''}" data-audio="off">Desactivado</button>
                        </div>
                    </div>

                    <!-- Reset -->
                    <div class="pref-group pref-actions">
                        <button class="btn-secondary" onclick="ReadingPreferences.resetPrefs()">
                            <i data-lucide="rotate-ccw"></i> Restaurar valores
                        </button>
                    </div>

                </div>
            </div>
        `;

        document.body.appendChild(panel);

        // Accessibility: trap focus in settings panel
        if (typeof AccessibilityManager !== 'undefined') {
            AccessibilityManager.trapFocus(panel);
        }

        // Setup event listeners
        panel.querySelectorAll('[data-theme]').forEach(btn => {
            btn.onclick = () => setPref('theme', btn.dataset.theme);
        });
        panel.querySelectorAll('[data-fontsize]').forEach(btn => {
            btn.onclick = () => setPref('fontSize', btn.dataset.fontsize);
        });
        panel.querySelectorAll('[data-fontfamily]').forEach(btn => {
            btn.onclick = () => setPref('fontFamily', btn.dataset.fontfamily);
        });
        panel.querySelectorAll('[data-lineheight]').forEach(btn => {
            btn.onclick = () => setPref('lineHeight', btn.dataset.lineheight);
        });
        panel.querySelectorAll('[data-typewriter]').forEach(btn => {
            btn.onclick = () => setPref('typewriter', btn.dataset.typewriter === 'true');
        });

        panel.querySelectorAll('[data-audio]').forEach(btn => {
            btn.onclick = () => {
                if (typeof AudioSystem !== 'undefined') {
                    AudioSystem.toggle();
                    // Update button states
                    panel.querySelectorAll('[data-audio]').forEach(b => {
                        b.classList.toggle('active',
                            (b.dataset.audio === 'on' && AudioSystem.isEnabled()) ||
                            (b.dataset.audio === 'off' && !AudioSystem.isEnabled())
                        );
                    });
                }
            };
        });

        // Close on overlay click
        panel.onclick = (e) => {
            if (e.target === panel) closePanel();
        };

        if (typeof lucide !== 'undefined') {
            lucide.createIcons();
        }
    }

    /**
     * Close settings panel
     */
    function closePanel() {
        if (panel) {
            if (typeof AccessibilityManager !== 'undefined') {
                AccessibilityManager.releaseFocus(panel);
            }
            panel.remove();
            panel = null;
        }
    }

    /**
     * Set a preference
     */
    function setPref(key, value) {
        prefs[key] = value;
        savePrefs();
        applyPrefs();

        // Update active states in panel
        if (panel) {
            const dataAttr = `data-${key.toLowerCase()}`;
            panel.querySelectorAll(`[${dataAttr}]`).forEach(btn => {
                btn.classList.toggle('active', btn.getAttribute(dataAttr) === String(value));
            });
        }
    }

    /**
     * Reset to defaults
     */
    function resetPrefs() {
        prefs = { ...defaults };
        savePrefs();
        applyPrefs();
        closePanel();
        openPanel(); // Reopen to refresh UI
    }

    /**
     * Setup keyboard navigation
     */
    function setupKeyboardNav() {
        document.addEventListener('keydown', (e) => {
            // Ignore if typing in input
            if (e.target.tagName === 'INPUT' || e.target.tagName === 'TEXTAREA') return;

            // Space or Enter to continue
            if (e.code === 'Space' || e.code === 'Enter') {
                const continueBtn = document.querySelector('.continue-button');
                if (continueBtn) {
                    e.preventDefault();
                    continueBtn.click();
                }
            }

            // Number keys for choices
            if (e.key >= '1' && e.key <= '9') {
                const choices = document.querySelectorAll('.choices button:not(.continue-button)');
                const index = parseInt(e.key) - 1;
                if (choices[index] && !choices[index].classList.contains('choice-unavailable')) {
                    choices[index].click();
                }
            }

            // Escape to close panel
            if (e.code === 'Escape' && panel) {
                closePanel();
            }
        });
    }

    /**
     * Setup swipe navigation for mobile
     */
    function setupSwipeNav() {
        let touchStartY = 0;
        let touchEndY = 0;

        document.addEventListener('touchstart', (e) => {
            touchStartY = e.changedTouches[0].screenY;
        }, { passive: true });

        document.addEventListener('touchend', (e) => {
            touchEndY = e.changedTouches[0].screenY;
            handleSwipe();
        }, { passive: true });

        function handleSwipe() {
            const diff = touchStartY - touchEndY;
            // Swipe up (scroll down gesture) to continue
            if (diff > 50) {
                const continueBtn = document.querySelector('.continue-button');
                if (continueBtn) {
                    continueBtn.click();
                }
            }
        }
    }

    /**
     * Typewriter effect for text
     */
    function typewrite(element, text, callback) {
        if (!prefs.typewriter) {
            element.innerHTML = text;
            if (callback) callback();
            return;
        }

        element.innerHTML = '';
        let i = 0;
        const speed = prefs.typewriterSpeed;

        function type() {
            if (i < text.length) {
                // Handle HTML tags
                if (text[i] === '<') {
                    const tagEnd = text.indexOf('>', i);
                    if (tagEnd !== -1) {
                        element.innerHTML += text.substring(i, tagEnd + 1);
                        i = tagEnd + 1;
                    }
                } else {
                    element.innerHTML += text[i];
                    i++;
                }
                setTimeout(type, speed);
            } else if (callback) {
                callback();
            }
        }

        type();
    }

    /**
     * Get current preferences
     */
    function getPrefs() {
        return { ...prefs };
    }

    // Public API
    return {
        init,
        togglePanel,
        openPanel,
        closePanel,
        resetPrefs,
        typewrite,
        getPrefs,
        setPref
    };
})();

// Auto-initialize when DOM is ready
document.addEventListener('DOMContentLoaded', () => {
    // Delay slightly to ensure other modules are loaded
    setTimeout(() => ReadingPreferences.init(), 100);
});
