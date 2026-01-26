/**
 * SecurityValidator - Input sanitization and validation utilities
 * Prevents XSS and validates data integrity
 */
const SecurityValidator = (function() {
    'use strict';

    /**
     * Sanitize HTML string to prevent XSS
     * Allows only safe formatting tags
     * @param {string} html - Raw HTML string
     * @returns {string} Sanitized HTML
     */
    function sanitizeHTML(html) {
        if (typeof html !== 'string') return '';

        // Create a temporary element to parse HTML
        const temp = document.createElement('div');
        temp.textContent = html;
        let sanitized = temp.innerHTML;

        // Re-allow safe inline tags that Ink uses for formatting
        // Only <b>, <i>, <em>, <strong>, <br>, <p>, <span> with no attributes
        sanitized = sanitized
            .replace(/&lt;(\/?)b&gt;/gi, '<$1b>')
            .replace(/&lt;(\/?)i&gt;/gi, '<$1i>')
            .replace(/&lt;(\/?)em&gt;/gi, '<$1em>')
            .replace(/&lt;(\/?)strong&gt;/gi, '<$1strong>')
            .replace(/&lt;br\s*\/?&gt;/gi, '<br>')
            .replace(/&lt;(\/?)p&gt;/gi, '<$1p>');

        return sanitized;
    }

    /**
     * Sanitize text content (strip all HTML)
     * @param {string} text - Input text
     * @returns {string} Plain text
     */
    function sanitizeText(text) {
        if (typeof text !== 'string') return '';
        const temp = document.createElement('div');
        temp.textContent = text;
        return temp.innerHTML;
    }

    /**
     * Validate save data structure
     * @param {object} data - Parsed save data
     * @returns {boolean} Whether the data is valid
     */
    function validateSaveData(data) {
        if (!data || typeof data !== 'object') return false;

        // Required fields
        if (typeof data.version !== 'number') return false;
        if (typeof data.timestamp !== 'number') return false;
        if (!data.inkState) return false;

        // Version bounds
        if (data.version < 0 || data.version > 100) return false;

        // Timestamp sanity (not in the future by more than 1 day, not before 2024)
        const now = Date.now();
        const oneDay = 86400000;
        if (data.timestamp > now + oneDay) return false;
        if (data.timestamp < new Date('2024-01-01').getTime()) return false;

        // Description length
        if (data.description && data.description.length > 500) return false;

        // Preview validation
        if (data.preview) {
            if (typeof data.preview.day !== 'undefined') {
                if (typeof data.preview.day !== 'number' || data.preview.day < 1 || data.preview.day > 7) return false;
            }
        }

        // inkState must be a string (JSON serialized state)
        if (typeof data.inkState !== 'string') return false;

        // Size limit (5MB max for ink state)
        if (data.inkState.length > 5 * 1024 * 1024) return false;

        return true;
    }

    /**
     * Check localStorage quota before writing
     * @param {string} key - Storage key
     * @param {string} value - Value to write
     * @returns {boolean} Whether there's enough space
     */
    function checkStorageQuota(key, value) {
        try {
            // Estimate current usage
            let totalSize = 0;
            for (let i = 0; i < localStorage.length; i++) {
                const k = localStorage.key(i);
                totalSize += k.length + localStorage.getItem(k).length;
            }

            // Subtract existing key size if overwriting
            const existing = localStorage.getItem(key);
            if (existing) {
                totalSize -= key.length + existing.length;
            }

            // Add new size
            totalSize += key.length + value.length;

            // Conservative 4.5MB limit (typical browser limit is 5MB)
            const limit = 4.5 * 1024 * 1024;
            return totalSize * 2 < limit; // *2 for UTF-16 encoding
        } catch (e) {
            return false;
        }
    }

    /**
     * Safe JSON parse with validation
     * @param {string} jsonStr - JSON string
     * @returns {object|null} Parsed object or null on failure
     */
    function safeJSONParse(jsonStr) {
        try {
            if (typeof jsonStr !== 'string') return null;
            if (jsonStr.length > 10 * 1024 * 1024) return null; // 10MB limit
            return JSON.parse(jsonStr);
        } catch (e) {
            return null;
        }
    }

    // Public API
    return {
        sanitizeHTML,
        sanitizeText,
        validateSaveData,
        checkStorageQuota,
        safeJSONParse
    };
})();

// Expose to window
if (typeof window !== 'undefined') {
    window.SecurityValidator = SecurityValidator;
}
