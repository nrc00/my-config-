local o = vim.opt
local g = vim.g
local c = vim.cmd

-- Basic settings
o.number = true
o.relativenumber = true

-- Install plugins with vim.pack
vim.pack.add({ 'https://github.com/ibhagwan/fzf-lua' })
vim.pack.add({ 'https://github.com/echasnovski/mini.icons' })

-- Setup mini.icons
require('mini.icons').setup()
require('mini.icons').mock_nvim_web_devicons()

-- Setup fzf-lua
require('fzf-lua').setup({})

-- Test keymap
vim.keymap.set('n', '<leader>ff', '<cmd>FzfLua files<cr>')