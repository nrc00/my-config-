----------------------------------
-- neovim 0.12 ; current year 2026
----------------------------------
-- vim.pack is neovim 0.12 native package manager
local o = vim.opt
local l = vim.lsp
local g = vim.g
local c = vim.cmd
local k = vim.keymap
local p = vim.pack
local gh = function(repo)
	return "https://github.com/" .. repo
end
local f = vim.api.nvim_create_autocmd

o.number = true
--AUTO COMPLETE DELTE OR DISABLE IF BLINK IS USED
-- o.autocomplete = true;
o.relativenumber = true
o.cursorline = true
o.signcolumn = "yes"
o.colorcolumn = "90"
o.list = true
o.listchars = {
	tab = "󱦰",
	trail = "",
	extends = "󱞪",
	precedes = "󱞦",
}
o.laststatus = 3
o.showmode = false -- Hide the redundant "-- INSERT --" text

o.copyindent = true -- Copies the previous line's indentation when wrapping
o.preserveindent = true -- Keeps the indent structure as much as possible

o.linebreak = true
o.breakindent = true
o.scrolloff = 4
o.sidescrolloff = 8

o.smartcase = true

o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.smartindent = true

o.mouse = "a"
o.clipboard = "unnamedplus"

o.splitright = true
o.splitbelow = true

o.swapfile = false
o.updatetime = 400
o.timeoutlen = 400
o.inccommand = "split"

o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldlevel = 99

o.jumpoptions = "stack"

g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0
g.loaded_netrw = 0
g.loaded_netrwPlugin = 0

g.mapleader = " "
g.maplocalleader = " "

o.cmdheight = 0

-- available in neovim 0.12
-- this colorscheme works and config is correct
c.colorscheme("catppuccin")

p.add({
	gh("m4xshen/hardtime.nvim"),
	gh("tris203/precognition.nvim"),
	gh("windwp/nvim-autopairs"),
	gh("echasnovski/mini.icons"),
	gh("ibhagwan/fzf-lua"),
	gh("neovim/nvim-lspconfig"),
	gh("stevearc/conform.nvim"),
	gh("romus204/tree-sitter-manager.nvim"),
	gh("MeanderingProgrammer/render-markdown.nvim"),
	gh("nvim-mini/mini.clue"),
	{
		src = gh("saghen/blink.cmp"),
		version = vim.version.range("v^1.10.2"), -- any 1.x.x version
	},
	-- gh("rafamadriz/friendly-snippets"),
})
require("precognition").toggle()
-- nvim auto pairs
require("nvim-autopairs").setup()

require("mini.clue").setup({
	triggers = {
		-- Leader triggers
		{ mode = { "n", "x" }, keys = "<Leader>" },
	},
})

-- render markdown
require("render-markdown").setup({})
-- i want to make a code that will check if there is already sitter for any language is installed
-- it shouldnt overlap install
require("tree-sitter-manager").setup({
	ensure_installed = {},
	auto_install = false,
	highlight = true,
	border = "rounded",
})
require("hardtime").setup()

require("blink.cmp").setup({
	completion = {
		menu = { enabled = false }, -- no popup menu
		documentation = { auto_show = false }, -- no doc window
		ghost_text = { enabled = true }, -- only ghost text
		-- fuzzy & typo tolerance (merged)
		fuzzy = {
			max_typo_distance = 2,
			min_word_len_for_typo = 3,
			use_proximity = true,
		},
	},
	sources = {
		default = { "lsp", "path", "buffer" },
		per_source = {
			buffer = { fuzzy = true },
			lsp = { fuzzy = true },
			path = { fuzzy = true },
		},
	},
	keymap = { preset = "super-tab" },
	accept = { auto_brackets = { enabled = false } },
	cmdline = { enabled = true },
	appearance = { nerd_font_variant = "Nerd Font mono" },
	highlight = {}, -- uses CmpGhostText group by default
})

require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons()

require("fzf-lua").setup({})

l.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
})

l.enable({
	"bashls",
	"lua_ls",
	"marksman",
	"pyright",
	"texlab",
	"tinymist",
	"jsonls",
	"clangd",
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_format" },
		sh = { "shfmt" },
		bash = { "shfmt" },
		zsh = { "shfmt" },
		json = { "prettier" },
		jsonc = { "prettier" },
		markdown = { "prettier" },
		yaml = { "yamlfmt" },
		toml = { "taplo" },
		typst = { "typstyle" },
		c = { "clang_format" },
		cpp = { "clang_format" },

		["_"] = { "prettier" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})

k.set("n", "<leader>f", ":FzfLua files<CR>", { desc = "FzfLua files" })
k.set("n", "<leader>h", ":FzfLua helptags<CR>", { desc = "FzfLua help" })
k.set("n", "<leader>q", ":q<CR>", { desc = "Exit" })
k.set("n", "<leader>w", ":w<CR>", { desc = "SAVE" })
k.set("n", "<leader>g", ":Precognition toggle<CR>", { desc = "GUIDE" })
k.set("n", "<leader>md", ":RenderMarkdown toggle<CR>", { desc = "markdown" })
-- HELP PAGE OPENING
f("FileType", {
	pattern = "help",
	callback = function()
		if vim.fn.winnr("$") > 1 then
			vim.cmd.wincmd("T")
		end
	end,
})
-- search online if you dont get anything
