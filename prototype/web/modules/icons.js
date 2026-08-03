/**
 * Icons - SVG inline, sin red
 *
 * Reemplaza al CDN de Lucide. La UI dependía de que unpkg.com respondiera:
 * si el CDN fallaba o estaba bloqueado, los botones del header quedaban como
 * cuadraditos vacíos y las stats sin su icono, sin ningún texto de respaldo.
 *
 * Mantiene el mismo contrato que Lucide: cualquier elemento con
 * [data-lucide="nombre"] se reemplaza por su SVG. Los dibujos son propios y
 * más simples que los de Lucide, no calcados.
 */
const Icons = (function () {
    'use strict';

    // Cada entrada es el contenido interior de un <svg> 24x24 con stroke.
    const PATHS = {
        'zap': '<path d="M13 2 4 14h7l-1 8 9-12h-7z"/>',
        'users': '<circle cx="9" cy="8" r="3.2"/><path d="M3 20c0-3.3 2.7-5 6-5s6 1.7 6 5"/><path d="M16.5 5.5a3.2 3.2 0 0 1 0 5.6"/><path d="M18 15.5c2 .8 3 2.2 3 4.5"/>',
        'flame': '<path d="M12 2c1.5 3.5-1.5 5-1.5 7.5A3 3 0 0 0 13 12c1.5-.8 1.8-2.3 1.8-2.3C17 11 18 13 18 15a6 6 0 0 1-12 0c0-4 3.5-5.5 6-13z"/>',
        'shield': '<path d="M12 3l7 3v5.5c0 4.5-3 8-7 9.5-4-1.5-7-5-7-9.5V6z"/>',
        'anchor': '<circle cx="12" cy="5" r="2.2"/><path d="M12 7.2V21"/><path d="M6 11H4a8 8 0 0 0 16 0h-2"/>',
        'info': '<circle cx="12" cy="12" r="9"/><path d="M12 11v5"/><path d="M12 7.6v.5"/>',
        'book-open': '<path d="M3 5h5.5c1.4 0 2.5.7 3.5 1.6C13 5.7 14.1 5 15.5 5H21v13h-5.5c-1.4 0-2.5.7-3.5 1.6-1-.9-2.1-1.6-3.5-1.6H3z"/><path d="M12 6.6V19.6"/>',
        'save': '<path d="M4 4h12l4 4v12H4z"/><path d="M8 4v5h7V4"/><path d="M8 20v-6h8v6"/>',
        'play': '<path d="M7 4l13 8-13 8z"/>',
        'folder-open': '<path d="M3 7a1 1 0 0 1 1-1h5l2 2.5h8a1 1 0 0 1 1 1V10"/><path d="M3 7v12h15.5l2.5-8H5.5z"/>',
        'settings': '<circle cx="12" cy="12" r="3"/><path d="M12 2v3M12 19v3M2 12h3M19 12h3M4.9 4.9l2.1 2.1M17 17l2.1 2.1M19.1 4.9L17 7M7 17l-2.1 2.1"/>',
        'x': '<path d="M6 6l12 12M18 6L6 18"/>',
        'arrow-left': '<path d="M20 12H4"/><path d="M10 6l-6 6 6 6"/>',
        'calendar': '<rect x="3" y="5" width="18" height="16" rx="1.5"/><path d="M3 10h18"/><path d="M8 3v4M16 3v4"/>',
        'coffee': '<path d="M4 9h13v6a5 5 0 0 1-5 5H9a5 5 0 0 1-5-5z"/><path d="M17 10h1.5a2.5 2.5 0 0 1 0 5H17"/><path d="M8 2v3M12 2v3"/>',
        'contrast': '<circle cx="12" cy="12" r="9"/><path d="M12 3a9 9 0 0 1 0 18z" fill="currentColor" stroke="none"/>',
        'dices': '<rect x="3" y="9" width="11" height="11" rx="1.5"/><path d="M8 6.5 A1.5 1.5 0 0 1 9.5 5H19a1.5 1.5 0 0 1 1.5 1.5V16"/><path d="M6.5 13.5v.01M10.5 16.5v.01"/>',
        'download': '<path d="M12 3v12"/><path d="M7 11l5 5 5-5"/><path d="M4 20h16"/>',
        'upload': '<path d="M12 21V9"/><path d="M7 13l5-5 5 5"/><path d="M4 4h16"/>',
        'fast-forward': '<path d="M3 5l8 7-8 7z"/><path d="M13 5l8 7-8 7z"/>',
        'flag': '<path d="M5 21V4"/><path d="M5 5h11l-2 3.5L16 12H5z"/>',
        'heart-pulse': '<path d="M12 20S4 14.5 4 9.2A4.2 4.2 0 0 1 12 7a4.2 4.2 0 0 1 8 2.2c0 1.3-.5 2.5-1.3 3.6"/><path d="M3 13h4l2-3 2.5 6 2-3H21"/>',
        'moon': '<path d="M20 13.5A8 8 0 0 1 10 3.6a8.5 8.5 0 1 0 10 9.9z"/>',
        'sun': '<circle cx="12" cy="12" r="4"/><path d="M12 2v2M12 20v2M2 12h2M20 12h2M4.9 4.9l1.5 1.5M17.6 17.6l1.5 1.5M19.1 4.9l-1.5 1.5M6.4 17.6l-1.5 1.5"/>',
        'mouse-pointer-click': '<path d="M5 3l6 16 2.2-6.2L19.5 11z"/><path d="M14 14l5 5"/>',
        'rotate-ccw': '<path d="M4 5v5h5"/><path d="M4.5 10a8 8 0 1 1 .7 6"/>',
        'user': '<circle cx="12" cy="8" r="3.6"/><path d="M4.5 20c0-3.8 3.4-6 7.5-6s7.5 2.2 7.5 6"/>',
        'heart': '<path d="M12 20S4 14.5 4 9.2A4.2 4.2 0 0 1 12 7a4.2 4.2 0 0 1 8 2.2C20 14.5 12 20 12 20z"/>',
        'heart-crack': '<path d="M12 20S4 14.5 4 9.2A4.2 4.2 0 0 1 12 7a4.2 4.2 0 0 1 8 2.2C20 14.5 12 20 12 20z"/><path d="M12 7l-2 3.5 3 1.5-2 3.5"/>',
        'lightbulb': '<path d="M9 17h6"/><path d="M10 20h4"/><path d="M8.5 14A5.5 5.5 0 1 1 15.5 14c-.6.8-1 1.6-1 2.5h-5c0-.9-.4-1.7-1-2.5z"/>',
        'sparkles': '<path d="M12 3l1.6 4.4L18 9l-4.4 1.6L12 15l-1.6-4.4L6 9l4.4-1.6z"/><path d="M18.5 15l.8 2.2 2.2.8-2.2.8-.8 2.2-.8-2.2-2.2-.8 2.2-.8z"/>',
        'trending-up': '<path d="M3 17l6-6 4 4 8-8"/><path d="M15 7h6v6"/>',
        'scroll': '<path d="M6 4h12v13a3 3 0 0 1-3 3H7a3 3 0 0 0 3-3V6a2 2 0 1 0-4 0v2h3"/>',
        'cloud': '<path d="M7 18h10a4 4 0 0 0 .3-8A5.5 5.5 0 0 0 6.6 11 3.5 3.5 0 0 0 7 18z"/>',
        'cloud-off': '<path d="M7 18h9a4 4 0 0 0 1.2-7.8"/><path d="M6.7 11A3.5 3.5 0 0 0 7 18"/><path d="M4 4l16 16"/>',
        'sunrise': '<path d="M12 4v5"/><path d="M8.5 9.5 12 6l3.5 3.5"/><path d="M3 17h18"/><path d="M6 13.5A6 6 0 0 1 18 13.5"/>',
        'git-branch': '<circle cx="7" cy="6" r="2.2"/><circle cx="7" cy="18" r="2.2"/><circle cx="17" cy="9" r="2.2"/><path d="M7 8.2v7.6"/><path d="M17 11.2c0 3-3 3.8-5.5 4.2"/>',
        'help-circle': '<circle cx="12" cy="12" r="9"/><path d="M9.6 9.6A2.5 2.5 0 0 1 14.5 10c0 1.7-2.5 2-2.5 3.6"/><path d="M12 17v.01"/>',
        // Atajos de teclado (nuevos, no existen en Lucide)
        'keyboard': '<rect x="2.5" y="6" width="19" height="12" rx="1.5"/><path d="M6 9.5v.01M9.5 9.5v.01M13 9.5v.01M16.5 9.5v.01M7.5 14h9"/>'
    };

    function svg(name, size = 16) {
        const body = PATHS[name];
        if (!body) return '';
        return `<svg class="icon icon-${name}" width="${size}" height="${size}" viewBox="0 0 24 24"` +
            ` fill="none" stroke="currentColor" stroke-width="1.75" stroke-linecap="round"` +
            ` stroke-linejoin="round" aria-hidden="true" focusable="false">${body}</svg>`;
    }

    function has(name) {
        return Object.prototype.hasOwnProperty.call(PATHS, name);
    }

    /**
     * Reemplaza los [data-lucide] de un subárbol por SVG inline.
     * Mismo punto de entrada que lucide.createIcons({ root }).
     */
    function render(root) {
        const scope = root || document;
        scope.querySelectorAll('[data-lucide]').forEach((el) => {
            const name = el.getAttribute('data-lucide');
            if (!has(name)) {
                // Nombre desconocido: no dejamos un hueco mudo. El title o el
                // texto del botón siguen siendo la etiqueta.
                el.remove();
                return;
            }
            const size = parseInt(el.style.width, 10) || 16;
            const holder = document.createElement('span');
            holder.innerHTML = svg(name, size);
            const node = holder.firstElementChild;
            if (el.className) node.classList.add(...el.className.split(/\s+/).filter(Boolean));
            el.replaceWith(node);
        });
    }

    return { svg, has, render, createIcons: render };
})();

// Compatibilidad: los módulos existentes llaman lucide.createIcons(...).
if (typeof window !== 'undefined' && typeof window.lucide === 'undefined') {
    window.lucide = { createIcons: (opts) => Icons.render(opts && opts.root) };
}
