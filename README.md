# juliaLSP-nvim-dotfiles 🚀

Mi entorno portátil y minimalista para **Neovim**, optimizado a fondo para el desarrollo fluido en **Julia**, **Lua** y **C/C++**.
Lua es porque por defecto es lenguaje base para revisar errores en el init.lua, C/C++ por existe necesitar de generar una libreria.
Este espacio está pensado para ser ligero, productivo y completamente desacoplado de configuraciones globales del sistema operativo.

---

## Características Principales

*   Julia Devflow Nativo:** Integración directa para enviar y ejecutar código en el REPL de Julia al instante con `<leader>jr`.
*   Servidor de Lenguajes (LSP):** Autocompletado inteligente y diagnósticos integrados en tiempo real para `Julia`, `Lua`, y `C/C++` mediante `nvim-lspconfig`.
*   Servidor en Vivo Embebido:** Lanza un servidor dinámico con recarga automática directo desde tus archivos HTML usando `LiveServer.jl` con el atajo `<leader>lv`.
*   Interfaz Estética:** Apariencia Nord elegante y limpia, barra de estado informativa (`lualine`), e intuitivo árbol de archivos (`nvim-tree`).
*   Navegación Ultra Rápida:** Buscador de archivos y textos en tiempo real potenciado por `Telescope`.

---

## Atajos de Teclado Clave (Keymaps)

El botón `<Leader>` está asignado al **Espacio (` `)**.

### Operaciones de Código
*   `<Leader>jr` ➔ Levanta el REPL de Julia y ejecuta el archivo actual en una terminal integrada.
*   `<Leader>lv` ➔ Inicia un servidor web `LiveServer` automático (exclusivo para archivos HTML).

### Productividad & Navegación
*   `<Leader>ff` ➔ Buscar archivos en tu espacio de trabajo.
*   `<Leader>fg` ➔ Buscar palabras dentro de todos tus archivos (*Live Grep*).
*   `<Leader>e`  ➔ Abrir / Cerrar el explorador de archivos izquierdo (`NvimTree`).
*   `<Leader>ft` ➔ Desplegar una terminal flotante integrada (`PowerShell`).

### Comodidad del Sistema
*   `Ctrl + s` ➔ Guardar todos los archivos abiertos (funciona tanto en modo Normal como Insertar).
*   `Ctrl + a` ➔ Seleccionar absolutamente todo el texto del archivo.
*   `Ctrl + c` ➔ Copiar el texto seleccionado directamente al portapapeles del sistema.
*   `Ctrl + x` ➔ Guardar todos los cambios abiertos y cerrar Neovim por completo.

---

## Gestor de Plugins

Todo el entorno se autogestiona usando **Lazy.nvim**. Al iniciar Neovim en una máquina nueva por primera vez, el gestor clonará e instalará automáticamente todos los complementos declarados.

