local o                   = vim.opt
local l                   = vim.lsp
local g                   = vim.g
local c                   = vim.cmd
local k                   = vim.keymap
local p                   = vim.pack

-- UI
o.number                  = true
o.relativenumber          = true
o.cursorline              = true
o.signcolumn              = "yes"
o.colorcolumn             = "120"
o.list                    = true
o.listchars               = {
  tab      = '>─',
  trail    = '·',
  extends  = '→',
  precedes = '←',
}
o.laststatus              = 3
o.showmode                = false

-- Edges & wrapping
o.linebreak               = true
o.breakindent             = true
o.scrolloff               = 4
o.sidescrolloff           = 8

-- Search
o.smartcase               = true

-- Indentation
o.tabstop                 = 2
o.shiftwidth              = 2
o.expandtab               = true
o.smartindent             = true

-- Mouse & clipboard
o.mouse                   = "a"
o.clipboard               = "unnamedplus"

-- Window splits
o.splitright              = true
o.splitbelow              = true

-- Behaviour
o.swapfile                = false
o.updatetime              = 250
o.timeoutlen              = 300
o.inccommand              = "split"

-- Folding
o.foldmethod              = "expr"
o.foldexpr                = "v:lua.vim.treesitter.foldexpr()"
o.foldlevel               = 99

-- Jump list
o.jumpoptions             = "stack"

-- Providers (disable for speed)
g.loaded_node_provider    = 0
g.loaded_perl_provider    = 0
g.loaded_python3_provider = 0
g.loaded_ruby_provider    = 0
g.loaded_netrw            = 1
g.loaded_netrwPlugin      = 1

-- Leaders
g.mapleader               = " "
g.maplocalleader          = " "

-- Colorscheme (built‑in)
c.colorscheme("catppuccin")

-- Command line
o.cmdheight = 0

-----------------
-- PLUGIN MANAGER
-----------------

-- Add all plugins at once
p.add({
  'https://github.com/echasnovski/mini.icons',
  'https://github.com/ibhagwan/fzf-lua',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/stevearc/conform.nvim',
})

-- Configure mini.icons (drop‑in replacement for nvim-web-devicons)
require('mini.icons').setup()
require('mini.icons').mock_nvim_web_devicons()

-- Configure fzf‑lua (bat, delta, etc. auto‑detected)
require('fzf-lua').setup({})

-- LSP servers: register and launch with default settings
-- Uses nvim-lspconfig under the hood
l.enable({
  'bashls',   -- bash-language-server
  'lua_ls',   -- lua-language-server
  'marksman', -- marksman
  'pyright',  -- pyright
  'texlab',   -- texlab
  'tinymist', -- tinymist
  'jsonls',   -- vscode-json-languageserver
  -- Uncomment if you want clangd (C/C++) from clang package:
  'clangd',
})

-- Formatters: setup conform.nvim with your installed tools
require('conform').setup({
  formatters_by_ft = {
    lua      = { 'stylua' },
    python   = { 'ruff_format' },
    sh       = { 'shfmt' },
    bash     = { 'shfmt' },
    zsh      = { 'shfmt' },
    json     = { 'prettier' },
    jsonc    = { 'prettier' },
    markdown = { 'prettier' },
    yaml     = { 'yamlfmt' },
    toml     = { 'taplo' },
    typst    = { 'typstyle' },
    c        = { 'clang_format' },
    cpp      = { 'clang_format' },
    -- ruff can also format Python; already covered above
    -- Use prettier for any filetype not listed:
    ['_']    = { 'prettier' },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})

-----------------
-- KEYMAPS
-----------------

-- Find files
k.set('n', '<leader>f', '<cmd>FzfLua<CR>', { desc = 'Find files' })
-- Quit window
k.set('n', '<leader>q', ':q<CR>', { desc = 'Exit' })
