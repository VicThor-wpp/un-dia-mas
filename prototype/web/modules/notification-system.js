/**
 * NotificationSystem - Visual notifications for stat changes and events
 */
const NotificationSystem = (function() {
    'use strict';

    let container = null;

    /**
     * Initialize the notification system
     */
    function init() {
        // Create container if it doesn't exist
        container = document.getElementById('notifications');

        if (!container) {
            container = document.createElement('div');
            container.id = 'notifications';
            container.className = 'notifications';

            const game = document.getElementById('game');
            if (game) {
                game.insertBefore(container, game.firstChild);
            } else {
                document.body.appendChild(container);
            }
        }
    }

    /**
     * Create icon HTML
     */
    function iconHTML(name, size = 16) {
        return `<i data-lucide="${name}" style="width:${size}px;height:${size}px;"></i>`;
    }

    /**
     * Show a notification
     * @param {string} message - Notification message
     * @param {string} type - Type: 'positive', 'negative', 'info', 'success', 'error', 'dice-success', 'dice-fail', 'dice-neutral'
     * @param {string} iconName - Optional Lucide icon name
     */
    function show(message, type = 'info', iconName = null) {
        if (!container) init();

        const duration = ConfigManager.get('ui.notifications.duration', 2500);
        const fadeOutDuration = ConfigManager.get('ui.notifications.fadeOutDuration', 500);

        const notif = document.createElement('div');
        notif.className = `notification ${type}`;

        const icon = iconName ? iconHTML(iconName, 16) : '';
        const safeMessage = typeof SecurityValidator !== 'undefined'
            ? SecurityValidator.sanitizeText(message)
            : message;
        notif.innerHTML = `${icon} ${safeMessage}`;

        container.appendChild(notif);

        // Refresh icons
        if (typeof lucide !== 'undefined') {
            lucide.createIcons({ root: notif });
        }

        // Auto-remove
        setTimeout(() => {
            notif.classList.add('fade-out');
            setTimeout(() => notif.remove(), fadeOutDuration);
        }, duration);

        return notif;
    }

    /**
     * Show stat change notification
     * @param {string} statId - Stat identifier
     * @param {number} diff - Change amount (positive or negative)
     */
    function showStatChange(statId, diff) {
        if (diff === 0) return;

        const stat = ConfigManager.getStat(statId);
        if (!stat) return;

        const type = diff > 0 ? 'positive' : 'negative';
        const sign = diff > 0 ? '+' : '';
        const message = `${stat.label} ${sign}${diff}`;

        show(message, type, stat.icon);
    }

    /**
     * Show dice roll notification
     * @param {number} roll - Dice value
     * @param {number} result - Result code (2=crit success, 1=success, 0=neutral, -1=crit fail)
     */
    function showDiceRoll(roll, result) {
        const resultInfo = ConfigManager.getDiceResult(result);

        let type;
        if (result === 0) {
            type = 'dice-neutral';
        } else if (result >= 1) {
            type = 'dice-success';
        } else {
            type = 'dice-fail';
        }

        const message = `${roll} - ${resultInfo.label}`;
        show(message, type, 'dices');
    }

    /**
     * Show threshold indicator notification
     * @param {string} indicator - Indicator label
     * @param {string} type - 'warning' or 'info'
     */
    function showThreshold(indicator, type = 'warning') {
        show(indicator, type === 'warning' ? 'negative' : 'info', 'alert-triangle');
    }

    /**
     * Clear all notifications
     */
    function clearAll() {
        if (container) {
            container.innerHTML = '';
        }
    }

    // Public API
    return {
        init,
        show,
        showStatChange,
        showDiceRoll,
        showThreshold,
        clearAll
    };
})();

// Expose to window
if (typeof window !== 'undefined') {
    window.NotificationSystem = NotificationSystem;
}
