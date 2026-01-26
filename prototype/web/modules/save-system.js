/**
 * SaveSystem - Persistent save/load with versioning and auto-save
 */
const SaveSystem = (function() {
    'use strict';

    const STORAGE_PREFIX = 'udm_';
    const VERSION = 1;
    const MAX_SLOTS = 3;

    let story = null;
    let autoSaveTimer = null;
    let onSaveCallback = null;
    let onLoadCallback = null;
    let saveLock = false;

    /**
     * Initialize the save system
     * @param {object} inkStory - The inkjs story instance
     * @param {object} options - Configuration options
     */
    function init(inkStory, options = {}) {
        story = inkStory;

        if (options.onSave) onSaveCallback = options.onSave;
        if (options.onLoad) onLoadCallback = options.onLoad;

        // Start auto-save if enabled
        const autoSaveEnabled = ConfigManager.get('ui.save.autoSave', true);
        const autoSaveInterval = ConfigManager.get('ui.save.autoSaveInterval', 30000);

        if (autoSaveEnabled) {
            startAutoSave(autoSaveInterval);
        }
    }

    /**
     * Create save data object
     * @param {string} description - Optional save description
     * @returns {object}
     */
    function createSaveData(description = '') {
        if (!story) return null;

        // Get preview data
        const diaActual = story.variablesState['dia_actual'] ?? 1;
        const diaNombre = ConfigManager.getDayName(diaActual);
        const energia = story.variablesState['energia'] ?? 4;
        const conexion = story.variablesState['conexion'] ?? 5;
        const llama = story.variablesState['llama'] ?? 3;
        const tieneLauro = story.variablesState['tiene_laburo'] ?? true;
        const vinculo = story.variablesState['vinculo'] || '';

        return {
            version: VERSION,
            timestamp: Date.now(),
            description: description || `Día ${diaActual} - ${diaNombre}`,
            preview: {
                day: diaActual,
                dayName: diaNombre,
                energia,
                conexion,
                llama,
                tieneLauro,
                vinculo
            },
            inkState: story.state.toJson()
        };
    }

    /**
     * Save to a specific slot
     * @param {number} slotId - Slot number (1-3)
     * @param {string} description - Optional save description
     * @returns {boolean}
     */
    function saveToSlot(slotId, description = '') {
        if (slotId < 1 || slotId > MAX_SLOTS) {
            console.error('Invalid slot ID:', slotId);
            return false;
        }
        if (saveLock) {
            console.warn('Save already in progress');
            return false;
        }
        saveLock = true;

        try {
            const saveData = createSaveData(description);
            if (!saveData) {
                saveLock = false;
                return false;
            }

            const serialized = JSON.stringify(saveData);
            const storageKey = `${STORAGE_PREFIX}save_${slotId}`;

            // Check storage quota before writing
            if (typeof SecurityValidator !== 'undefined' && !SecurityValidator.checkStorageQuota(storageKey, serialized)) {
                console.error('Storage quota exceeded');
                showNotification('Sin espacio para guardar', 'error');
                saveLock = false;
                return false;
            }

            localStorage.setItem(storageKey, serialized);

            if (onSaveCallback) onSaveCallback(slotId, saveData);

            saveLock = false;
            return true;
        } catch (e) {
            saveLock = false;
            console.error('Error saving to slot:', e);
            return false;
        }
    }

    /**
     * Save to auto-save slot
     * @returns {boolean}
     */
    function autoSave() {
        if (saveLock) return false;
        saveLock = true;

        try {
            const saveData = createSaveData('Auto-guardado');
            if (!saveData) {
                saveLock = false;
                return false;
            }

            const serialized = JSON.stringify(saveData);
            const storageKey = `${STORAGE_PREFIX}autosave`;

            if (typeof SecurityValidator !== 'undefined' && !SecurityValidator.checkStorageQuota(storageKey, serialized)) {
                console.warn('Storage quota exceeded for auto-save');
                saveLock = false;
                return false;
            }

            localStorage.setItem(storageKey, serialized);
            saveLock = false;
            return true;
        } catch (e) {
            saveLock = false;
            console.error('Error auto-saving:', e);
            return false;
        }
    }

    /**
     * Start auto-save timer
     * @param {number} interval - Interval in milliseconds
     */
    function startAutoSave(interval) {
        if (autoSaveTimer) clearInterval(autoSaveTimer);
        autoSaveTimer = setInterval(autoSave, interval);
    }

    /**
     * Stop auto-save timer
     */
    function stopAutoSave() {
        if (autoSaveTimer) {
            clearInterval(autoSaveTimer);
            autoSaveTimer = null;
        }
    }

    /**
     * Load save data from storage
     * @param {string} key - Storage key
     * @returns {object|null}
     */
    function loadSaveData(key) {
        try {
            const data = localStorage.getItem(key);
            if (!data) return null;

            const saveData = typeof SecurityValidator !== 'undefined'
                ? SecurityValidator.safeJSONParse(data)
                : JSON.parse(data);

            if (!saveData) return null;

            // Validate save data structure
            if (typeof SecurityValidator !== 'undefined' && !SecurityValidator.validateSaveData(saveData)) {
                console.warn('Invalid save data in slot:', key);
                return null;
            }

            return migrate(saveData);
        } catch (e) {
            console.error('Error loading save data:', e);
            return null;
        }
    }

    /**
     * Migrate save data to current version
     * @param {object} saveData - Save data object
     * @returns {object}
     */
    function migrate(saveData) {
        if (!saveData) return null;

        let data = { ...saveData };

        // Version migrations
        if (data.version < 1) {
            // Future migration: v0 -> v1
            data.version = 1;
        }

        // Add more migrations here as needed
        // if (data.version < 2) { ... }

        return data;
    }

    /**
     * Load from a specific slot
     * @param {number} slotId - Slot number (1-3)
     * @returns {boolean}
     */
    function loadFromSlot(slotId) {
        if (slotId < 1 || slotId > MAX_SLOTS) {
            console.error('Invalid slot ID:', slotId);
            return false;
        }

        try {
            const saveData = loadSaveData(`${STORAGE_PREFIX}save_${slotId}`);
            if (!saveData) return false;

            story.state.LoadJson(saveData.inkState);

            if (onLoadCallback) onLoadCallback(slotId, saveData);

            return true;
        } catch (e) {
            console.error('Error loading from slot:', e);
            return false;
        }
    }

    /**
     * Load from auto-save
     * @returns {boolean}
     */
    function loadAutoSave() {
        try {
            const saveData = loadSaveData(`${STORAGE_PREFIX}autosave`);
            if (!saveData) return false;

            story.state.LoadJson(saveData.inkState);

            if (onLoadCallback) onLoadCallback('auto', saveData);

            return true;
        } catch (e) {
            console.error('Error loading auto-save:', e);
            return false;
        }
    }

    /**
     * Get all save slot info (for UI)
     * @returns {Array<object>}
     */
    function getAllSlots() {
        const slots = [];

        // Auto-save slot
        const autoSaveData = loadSaveData(`${STORAGE_PREFIX}autosave`);
        slots.push({
            id: 'auto',
            name: 'Auto-guardado',
            data: autoSaveData,
            isEmpty: !autoSaveData
        });

        // Manual slots
        for (let i = 1; i <= MAX_SLOTS; i++) {
            const saveData = loadSaveData(`${STORAGE_PREFIX}save_${i}`);
            slots.push({
                id: i,
                name: `Partida ${i}`,
                data: saveData,
                isEmpty: !saveData
            });
        }

        return slots;
    }

    /**
     * Delete a save slot
     * @param {number|string} slotId - Slot ID
     * @returns {boolean}
     */
    function deleteSlot(slotId) {
        try {
            const key = slotId === 'auto' ? `${STORAGE_PREFIX}autosave` : `${STORAGE_PREFIX}save_${slotId}`;
            localStorage.removeItem(key);
            return true;
        } catch (e) {
            console.error('Error deleting slot:', e);
            return false;
        }
    }

    /**
     * Export all saves as JSON string
     * @returns {string}
     */
    function exportAll() {
        const exportData = {
            version: VERSION,
            exportDate: Date.now(),
            saves: {}
        };

        // Export auto-save
        const autoSaveData = loadSaveData(`${STORAGE_PREFIX}autosave`);
        if (autoSaveData) {
            exportData.saves.autosave = autoSaveData;
        }

        // Export manual saves
        for (let i = 1; i <= MAX_SLOTS; i++) {
            const saveData = loadSaveData(`${STORAGE_PREFIX}save_${i}`);
            if (saveData) {
                exportData.saves[`slot_${i}`] = saveData;
            }
        }

        return JSON.stringify(exportData, null, 2);
    }

    /**
     * Import saves from JSON string
     * @param {string} jsonStr - Exported JSON string
     * @returns {boolean}
     */
    function importAll(jsonStr) {
        try {
            const importData = JSON.parse(jsonStr);

            if (!importData.saves) {
                console.error('Invalid import data');
                return false;
            }

            // Import auto-save
            if (importData.saves.autosave) {
                localStorage.setItem(`${STORAGE_PREFIX}autosave`, JSON.stringify(migrate(importData.saves.autosave)));
            }

            // Import manual saves
            for (let i = 1; i <= MAX_SLOTS; i++) {
                if (importData.saves[`slot_${i}`]) {
                    localStorage.setItem(`${STORAGE_PREFIX}save_${i}`, JSON.stringify(migrate(importData.saves[`slot_${i}`])));
                }
            }

            return true;
        } catch (e) {
            console.error('Error importing saves:', e);
            return false;
        }
    }

    /**
     * Check if any save exists
     * @returns {boolean}
     */
    function hasSaves() {
        return getAllSlots().some(slot => !slot.isEmpty);
    }

    /**
     * Format timestamp for display
     * @param {number} timestamp
     * @returns {string}
     */
    function formatTimestamp(timestamp) {
        const date = new Date(timestamp);
        return date.toLocaleString('es-UY', {
            day: '2-digit',
            month: '2-digit',
            year: 'numeric',
            hour: '2-digit',
            minute: '2-digit'
        });
    }

    /**
     * Render save/load modal
     */
    function showModal() {
        const slots = getAllSlots();

        const modal = document.createElement('div');
        modal.className = 'modal-overlay';
        modal.innerHTML = `
            <div class="modal-content save-modal">
                <div class="modal-header">
                    <h2><i data-lucide="save" style="width:20px;height:20px;"></i> Guardar / Cargar</h2>
                    <button class="modal-close"><i data-lucide="x" style="width:20px;height:20px;"></i></button>
                </div>
                <div class="modal-body">
                    <div class="save-slots">
                        ${slots.map(slot => renderSlot(slot)).join('')}
                    </div>
                    <div class="save-actions">
                        <button class="btn-secondary" onclick="SaveSystem.handleExport()">
                            <i data-lucide="download" style="width:16px;height:16px;"></i> Exportar todo
                        </button>
                        <button class="btn-secondary" onclick="SaveSystem.handleImport()">
                            <i data-lucide="upload" style="width:16px;height:16px;"></i> Importar
                        </button>
                    </div>
                </div>
            </div>
        `;

        document.body.appendChild(modal);

        // Refresh Lucide icons
        if (typeof lucide !== 'undefined') {
            lucide.createIcons();
        }

        // Close handlers
        modal.querySelector('.modal-close').addEventListener('click', () => modal.remove());
        modal.addEventListener('click', (e) => {
            if (e.target === modal) modal.remove();
        });
    }

    /**
     * Render a single save slot
     * @param {object} slot
     * @returns {string}
     */
    function renderSlot(slot) {
        if (slot.isEmpty) {
            return `
                <div class="save-slot slot-empty" data-slot="${slot.id}">
                    <div class="slot-header">
                        <span class="slot-name">${slot.name}</span>
                    </div>
                    <div class="slot-content">
                        <p class="slot-empty-text">Vacío</p>
                    </div>
                    <div class="slot-actions">
                        ${slot.id !== 'auto' ? `<button class="btn-primary btn-small" onclick="SaveSystem.handleSave(${slot.id})">Guardar aquí</button>` : ''}
                    </div>
                </div>
            `;
        }

        const preview = slot.data.preview || {};
        return `
            <div class="save-slot" data-slot="${slot.id}">
                <div class="slot-header">
                    <span class="slot-name">${slot.name}</span>
                    <span class="slot-date">${formatTimestamp(slot.data.timestamp)}</span>
                </div>
                <div class="slot-content">
                    <p class="slot-desc">${slot.data.description || 'Sin descripción'}</p>
                    <div class="slot-preview">
                        <span class="preview-day">${preview.dayName || 'Día ?'}</span>
                        <span class="preview-stat">⚡${preview.energia || '?'}</span>
                        <span class="preview-stat">🤝${preview.conexion || '?'}</span>
                        <span class="preview-stat">🔥${preview.llama || '?'}</span>
                        ${preview.vinculo ? `<span class="preview-vinculo">★${preview.vinculo}</span>` : ''}
                    </div>
                </div>
                <div class="slot-actions">
                    <button class="btn-primary btn-small" onclick="SaveSystem.handleLoad('${slot.id}')">Cargar</button>
                    ${slot.id !== 'auto' ? `<button class="btn-secondary btn-small" onclick="SaveSystem.handleSave(${slot.id})">Sobrescribir</button>` : ''}
                    <button class="btn-danger btn-small" onclick="SaveSystem.handleDelete('${slot.id}')">Borrar</button>
                </div>
            </div>
        `;
    }

    /**
     * Handle save button click
     * @param {number} slotId
     */
    function handleSave(slotId) {
        if (saveToSlot(slotId)) {
            // Refresh modal
            document.querySelector('.modal-overlay')?.remove();
            showModal();
            showNotification('Partida guardada', 'success');
        } else {
            showNotification('Error al guardar', 'error');
        }
    }

    /**
     * Handle load button click
     * @param {number|string} slotId
     */
    function handleLoad(slotId) {
        const success = slotId === 'auto' ? loadAutoSave() : loadFromSlot(parseInt(slotId));

        if (success) {
            document.querySelector('.modal-overlay')?.remove();
            showNotification('Partida cargada', 'success');

            // Trigger game refresh
            if (typeof GameEngine !== 'undefined' && GameEngine.refresh) {
                GameEngine.refresh();
            } else if (typeof continueStory === 'function') {
                continueStory();
            } else {
                // Fallback: reload page
                location.reload();
            }
        } else {
            showNotification('Error al cargar', 'error');
        }
    }

    /**
     * Handle delete button click
     * @param {number|string} slotId
     */
    function handleDelete(slotId) {
        if (confirm('¿Borrar esta partida guardada?')) {
            if (deleteSlot(slotId)) {
                // Refresh modal
                document.querySelector('.modal-overlay')?.remove();
                showModal();
                showNotification('Partida borrada', 'success');
            }
        }
    }

    /**
     * Handle export button click
     */
    function handleExport() {
        const exportData = exportAll();
        const blob = new Blob([exportData], { type: 'application/json' });
        const url = URL.createObjectURL(blob);

        const a = document.createElement('a');
        a.href = url;
        a.download = `un_dia_mas_saves_${Date.now()}.json`;
        a.click();

        URL.revokeObjectURL(url);
        showNotification('Partidas exportadas', 'success');
    }

    /**
     * Handle import button click
     */
    function handleImport() {
        const input = document.createElement('input');
        input.type = 'file';
        input.accept = '.json';

        input.onchange = (e) => {
            const file = e.target.files[0];
            if (!file) return;

            const reader = new FileReader();
            reader.onload = (event) => {
                if (importAll(event.target.result)) {
                    document.querySelector('.modal-overlay')?.remove();
                    showModal();
                    showNotification('Partidas importadas', 'success');
                } else {
                    showNotification('Error al importar', 'error');
                }
            };
            reader.readAsText(file);
        };

        input.click();
    }

    /**
     * Show notification (uses NotificationSystem if available)
     * @param {string} message
     * @param {string} type
     */
    function showNotification(message, type) {
        if (typeof NotificationSystem !== 'undefined') {
            NotificationSystem.show(message, type);
        } else {
            console.log(`[${type}] ${message}`);
        }
    }

    // Public API
    return {
        init,
        saveToSlot,
        loadFromSlot,
        autoSave,
        loadAutoSave,
        getAllSlots,
        deleteSlot,
        exportAll,
        importAll,
        hasSaves,
        showModal,
        startAutoSave,
        stopAutoSave,
        handleSave,
        handleLoad,
        handleDelete,
        handleExport,
        handleImport,
        formatTimestamp
    };
})();

// Expose to window
if (typeof window !== 'undefined') {
    window.SaveSystem = SaveSystem;
}
