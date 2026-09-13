# juliaLSP-nvim-dotfiles

My portable and minimalist **Neovim** environment, fully optimized for a smooth development workflow in portable **Julia**.
Lua is included because it is the default base language for checking errors in `init.lua`, 
This setup is designed to be lightweight, productive, and completely decoupled from global operating system configurations, but it Works on Linux.

---

## Key Features

*   **Native Julia Devflow:** Direct integration to instantly send and execute code in the Julia REPL using `<leader>jr`.
*   **Language Server Protocol (LSP):** Intelligent autocompletion and integrated real-time diagnostics for `Julia`, `Lua`, and `C/C++` via `nvim-lspconfig`.
*   **Aesthetic Interface:** Clean and elegant Nord appearance, an informative status line (`lualine`), and an intuitive file tree (`nvim-tree`).
*   **Ultra-Fast Navigation:** Real-time file and text searching powered by `Telescope`.

---

## Keymaps

The `<Leader>` key is mapped to the **Spacebar (` `)**.

### Code Operations
*   `<Leader>jr` ➔ Launches the Julia REPL and executes the current file in an integrated terminal.

### Productivity & Telescope navigation
*   `<Leader>ff` ➔ Find files within your workspace.
*   `<Leader>fg` ➔ Search for text across all your files (*Live Grep*).
*   `<Leader>e`  ➔ Open / Close the left file explorer (`NvimTree`).
*   `<Leader>ft` ➔ Toggle an integrated floating terminal (`PowerShell`).

### System Convenience
*   `Ctrl + s` ➔ Save all open files (works in both Normal and Insert modes).
*   `Ctrl + a` ➔ Select all text in the current file.
*   `Ctrl + c` ➔ Copy the selected text directly to the system clipboard.
*   `Ctrl + x` ➔ Save all open changes and completely exit Neovim.

---

## Plugin Manager

The entire environment is self-managed using **Lazy.nvim**. When launching Neovim on a new machine for the first time, the manager will automatically clone and install all declared plugins.

## Notes
*  Change real user en julia_lsp.jl
*  Put in path, I use portable **gcc/x86_64-w64-mingw32/14.2.0** for tree-sitter + make for telescope. 
