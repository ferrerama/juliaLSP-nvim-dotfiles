local o=vim.opt
o.autoindent = true
o.smartindent = true
o.expandtab = true
o.tabstop = 3
o.shiftwidth = 3
o.cursorline = true
vim.g.mapleader = " "

local julia_base_path = vim.fn.expand("~") .. "/ws/julia"
vim.g.julia_executable_path = julia_base_path .. "/bin/julia.exe"
vim.g.julia_project_path    = julia_base_path .. "/env"
vim.env.PATH = vim.env.PATH .. ";" .. vim.fn.expand("~") .. "/ws/editor/config/rg"

vim.api.nvim_create_autocmd("FileType", {
  pattern = "julia",
  callback = function()
    vim.keymap.set("n", "<leader>jr", function()
      local file = vim.fn.expand("%:p"):gsub("\\", "/")
      local cmd = "julia --project=@. --banner=no --quiet -i"
      vim.cmd("botright 11split | terminal " .. cmd)
      vim.cmd("sleep 301m")
      vim.cmd("startinsert")
      -- local include_cmd = "@async include(\"" .. file .. "\")\n"
      local include_cmd = "include(\"" .. file .. "\")\n"
      vim.fn.chansend(vim.b.terminal_job_id, include_cmd)
    end, { noremap = true, silent = true, buffer = true, desc = "Exe REPL" })
  end,
})


local lazy_data_path = vim.fn.stdpath("data")
local lazypath = lazy_data_path .. "/lazy/lazy.nvim"
local plugins_dir = vim.fn.stdpath("config") .. "/plugins"

if not vim.loop.fs_stat(lazypath) then
 vim.fn.system({
 "git",
 "clone",
 "--filter=blob:none",
 "https://github.com/folke/lazy.nvim.git",
 lazypath,
})
end

vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
-- PLUGS
{
"neovim/nvim-lspconfig",
ft = { "julia", "lua"},
dependencies = {
"hrsh7th/nvim-cmp",
"hrsh7th/cmp-nvim-lsp",
"hrsh7th/cmp-buffer",
"hrsh7th/cmp-path",
"hrsh7th/cmp-cmdline",
"L3MON4D3/LuaSnip",
"saadparwaiz1/cmp_luasnip",
"rafamadriz/friendly-snippets",
},

config = function()
 local cmp = require("cmp")
 local luasnip = require("luasnip")

 require("luasnip.loaders.from_vscode").lazy_load()

 cmp.setup({
 snippet = {
  expand = function(args)
  luasnip.lsp_expand(args.body)
  end,
},

mapping = cmp.mapping.preset.insert({
 ["<Tab>"] = cmp.mapping.select_next_item(),
 ["<S-Tab>"] = cmp.mapping.select_prev_item(),
 ["<CR>"] = cmp.mapping.confirm({ select = true }),
}),
 sources = cmp.config.sources({
 { name = "nvim_lsp" },
 { name = "luasnip" },
 }, {
 { name = "buffer" },
 { name = "path" },
 }),

formatting = {
  fields = { "abbr" },
  format = function(entry, vim_item)
  entry.completion_item.detail = nil
  return vim_item
  end,
 }
})

vim.diagnostic.config({
  underline = true,
  virtual_text = false,
  signs = true,
  update_in_insert = true,
})

vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = {"*"},
  callback = function()
    local mode = vim.fn.mode()
    if mode == "n" then
      vim.diagnostic.config({ virtual_text = true })
    else
      vim.diagnostic.config({ virtual_text = false })
    end
  end,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("lua_ls", {
cmd = { vim.fn.expand("~") .. "/ws/julia/env/lua_lsp/bin/lua-language-server.exe" },
filetypes = { "lua" },
 capabilities = capabilities,
 settings = {
 Lua = {
 runtime = { version = "LuaJIT" },
 diagnostics = { globals = { "vim" } },
 workspace = { checkThirdParty = false },
 telemetry = { enable = false },
},
autostart = true,
 },
})
vim.lsp.enable("lua_ls")

vim.lsp.config("julials", {
 cmd = { "julia", "--project=@.", vim.fn.expand("~") .. "/ws/julia/env/jul_lsp/lsp_server.jl" },
 filetypes = { "julia" },
 root_dir = vim.fs.root(0, { "Project.toml", ".git" }),
 autostart = true,
 capabilities = capabilities
})
vim.lsp.enable("julials")

vim.log.level = vim.log.levels.DEBUG
 end,
},

{
"nvim-tree/nvim-tree.lua",
dependencies = { "nvim-tree/nvim-web-devicons" },
config = function()
 require("nvim-tree").setup({
 view = {
 width = 30,
 side = "left",
 preserve_window_proportions = true,
},
renderer = {
 highlight_git = true,
 icons = {
 show = {
 file = true,
 folder = true,
 folder_arrow = true,
  git = true,
 },
},
},
filters = {
 dotfiles = false,
 custom = { ".DS_Store", "thumbs.db" },
},
git = {
 enable = true,
 ignore = false,
 },
})
vim.keymap.set("n", "<leader>t", ":NvimTreeFindFile<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
end,
},

{
"m4xshen/autoclose.nvim",
config = true
},

{
 "nvim-lualine/lualine.nvim",
lazy = false,
config = function()
require("lualine").setup({
options = {
icons_enabled = true,
 theme = "auto",
 component_separators = { left = "", right = "" },
 section_separators = { left = "", right = "" },
 disabled_filetypes = {},
 always_divide_middle = true,
 globalstatus = false,
},
sections = {
 lualine_a = { "mode" },
 lualine_b = { "branch", "diff", "diagnostics" },
 lualine_c = {
 {
"filename",
file_status = true,
path = 1,
},
},
 lualine_x = { "encoding", "filetype" },
 lualine_y = { "progress" },
 lualine_z = { "location" },
},
 inactive_sections = {
 lualine_a = { "diagnostics" },
 lualine_b = {},
 lualine_c = {
{
"filename",
 file_status = true,
 path = 1,
},
},
 lualine_x = { "location" },
 lualine_y = {},
 lualine_z = {},
 },
 tabline = {},
 extensions = {},
 })
 end,
},

{
"nvim-telescope/telescope.nvim",
keys = {
 { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "files" },
 { "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Tex" },
 { "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "HTags" },
 { "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Buf" },
 { "<leader>fz", function() require("telescope").extensions.lazy.lazy() end, desc = "Lazy" },
},
dependencies = {
 "nvim-lua/plenary.nvim",
 { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
 { "tsakirist/telescope-lazy.nvim" },
 },
 config = function()
 local telescope = require("telescope")
 telescope.setup({
  defaults = {
  layout_strategy = "horizontal",
  sorting_strategy = "ascending",
  layout_config = {
  prompt_position = "top",
  },
 },
})
 pcall(telescope.load_extension, "fzf")
 pcall(telescope.load_extension, "lazy")
end,
},

{
"nvim-treesitter/nvim-treesitter",
opts = {
 ensure_installed = { "julia", "lua" },
 highlight = { enable = true },
 indent = { enable = true },
},
 build = ":TSUpdate",
},

{
"voldikss/vim-floaterm",
cmd = { "FloatermNew", "FloatermToggle" },
keys = {
 { "<leader>ft", "<cmd>FloatermNew pwsh -NoLogo<cr>", desc = "PFloa" },
},
config = function()
 vim.g.floaterm_wintype = "split"
 vim.g.floaterm_height = 0.3
 vim.opt.splitright = true
 end,
},

{
"shaunsingh/nord.nvim",
lazy = false,
priority = 1000,
config = function()
 vim.g.nord_disable_background = true
 vim.cmd.colorscheme("nord")
end,
},

-- = FIN PLUGS =
}, {
root = plugins_dir,
})
vim.keymap.set('v', '<C-c>', '"+y', { desc = 'Copy' })
vim.keymap.set('n', '<C-a>', 'ggVG', { desc = 'Selec' })
vim.keymap.set('n', '<C-s>', ':wa<CR>', { desc = 'Guardar todos' })
vim.keymap.set('i', '<C-s>', '<Esc>:wa<CR>', { desc = 'Guardar todos (insert)' })
vim.keymap.set('n', '<C-q>', ':q<CR>', { desc = 'Cerrar ventana' })
vim.keymap.set('n', '<C-x>', ':wqall<CR>', { desc = 'Guardar y salir de todo' })
vim.keymap.set('i', '<C-x>', '<Esc>:wqall<CR>', { desc = 'Guardar y salir de todo (insert)' })