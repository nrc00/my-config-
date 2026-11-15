-- autocommand
-- opens help page in new tab
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	callback = function()
		if vim.fn.winnr("$") > 1 then
			vim.cmd.wincmd("T")
		end
	end,
})
-- options
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.opt.cmdheight = 0
vim.opt.swapfile = false
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.cursorline = true
vim.opt.scrolloff = 999
vim.opt.smoothscroll = true
vim.opt.wrap = true
vim.opt.linebreak = true

-- fold option
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99

-- ui2
require("vim._core.ui2").enable({})

-- GLOBAL KEYMAPS
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit" })
vim.keymap.set("n", "<leader>c", ":", { desc = "Command" })
vim.keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- ui
vim.pack.add({
	"https://github.com/folke/todo-comments.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/nvim-mini/mini.nvim",
})
require("todo-comments").setup()
require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons()
-- colorscheme
vim.pack.add({ "https://github.com/EdenEast/nightfox.nvim" })
require("nightfox").setup({})
vim.cmd.colorscheme("terafox")

-- ui widgets
vim.pack.add({ "https://github.com/akinsho/bufferline.nvim" })
require("bufferline").setup({})

vim.pack.add({ "https://github.com/folke/which-key.nvim" })
require("which-key").setup({ preset = "classic" })

vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })
require("lualine").setup({
	options = {
		component_separators = " ",
		section_separators = " ",
		always_divide_middle = false,
		globalstatus = true,
	},
	sections = {
		lualine_c = {
			"%=",
			"mode",
			"diff",
			"branch",
			"location",
			"selectioncount",
			"filetype",
			"progress",
			"searchcount",
			"lsp_status",
			"diagnostics",
			"encoding",
			"hostname",
			"fileformat",
			"%=",
		},
		lualine_a = {},
		lualine_b = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
})

-- treesitter
vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })
require("nvim-treesitter").install({
	"c",
	"cpp",
	"java",
	"lua",
	"python",
	"rust",
	"zig",
	"markdown",
	"markdown_inline",
	"json",
	"go",
	"typst",
})

-- snippets
vim.pack.add({
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/L3MON4D3/LuaSnip",
})
require("luasnip.loaders.from_vscode").lazy_load()

-- completion
vim.pack.add({
	"https://github.com/onsails/lspkind.nvim",
	"https://github.com/hrsh7th/nvim-cmp",
	"https://github.com/hrsh7th/cmp-nvim-lsp",
	"https://github.com/saadparwaiz1/cmp_luasnip",
	"https://github.com/hrsh7th/cmp-buffer",
	"https://github.com/hrsh7th/cmp-cmdline",
	"https://github.com/hrsh7th/cmp-path",
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/hrsh7th/cmp-calc",
})

require("nvim-autopairs").setup({})
require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())

require("cmp").setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	sources = require("cmp").config.sources({
		{ name = "calc", keyword_length = 1 },
		{ name = "nvim_lsp", keyword_length = 1 },
		{ name = "path", keyword_length = 1 },
		{ name = "buffer", keyword_length = 1 },
		{ name = "luasnip", keyword_length = 1 },
	}),
	mapping = {
		-- ── Super-Tab ──────────────────────────────────────────────
		["<Tab>"] = require("cmp").mapping(function(fallback)
			if require("cmp").visible() then
				require("cmp").select_next_item()
			elseif require("luasnip").locally_jumpable(1) then
				require("luasnip").jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = require("cmp").mapping(function(fallback)
			if require("cmp").visible() then
				require("cmp").select_prev_item()
			elseif require("luasnip").locally_jumpable(-1) then
				require("luasnip").jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),

		["<CR>"] = require("cmp").mapping(function(fallback)
			if require("cmp").visible() then
				if require("luasnip").expandable() then
					require("luasnip").expand()
				else
					require("cmp").confirm({ select = true })
				end
			else
				fallback()
			end
		end),
	},
	formatting = {
		format = require("lspkind").cmp_format({
			preset = "codicons",
			maxwidth = 50,
			ellipsis_char = "...",
		}),
	},
})

-- cmdline
require("cmp").setup.cmdline({ "/", "?" }, {
	mapping = require("cmp").mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

require("cmp").setup.cmdline(":", {
	mapping = require("cmp").mapping.preset.cmdline(),
	sources = require("cmp").config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})
-- =============================================================================
--  9. LSP  (per-ft servers; capabilities come from cmp-nvim-lsp above)
--     c/cpp=clangd   zig=zls   go=gopls   md=marksman
--     py=basedpyright+ruff   java=jdtls   typst=tinymist
--     lua=lua_ls   rust=rust-analyzer   toml=tombi   json=jsonls
-- =============================================================================
vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })
vim.lsp.config("*", {
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

vim.lsp.enable("clangd")
vim.lsp.enable("zls")
vim.lsp.enable("gopls")
vim.lsp.enable("marksman")
vim.lsp.enable("basedpyright")
vim.lsp.enable("ruff")
vim.lsp.enable("jdtls")
vim.lsp.enable("tinymist")
vim.lsp.enable("lua_ls")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("tombi")
vim.lsp.enable("jsonls")

-- =============================================================================
-- 10. FORMATTER  (conform; falls back to LSP if no formatter for ft)
-- =============================================================================
vim.pack.add({ "https://github.com/stevearc/conform.nvim" })
require("conform").setup({
	formatters_by_ft = {
		c = { "clang-format" },
		cpp = { "clang-format" },
		go = { "goimports" },
		json = { "prettier" },
		jsonc = { "prettier" },
		lua = { "stylua" },
		markdown = { "prettier" },
		python = { "ruff_format" },
		rust = { "rustfmt" },
		toml = { "tombi" },
		typst = { "typstyle" },
		zig = { "zigfmt" },
		java = { "astyle" },
	},
	formatters = {
		astyle = {
			command = "astyle",
			args = { "--style=java", "--indent=spaces=8" },
			stdin = true,
		},
	},
	default_format_opts = { lsp_format = "fallback" },
	format_on_save = {},
})

-- =============================================================================
-- 11. PICKER  (fzf-lua; also used by tiny-code-action below)
-- =============================================================================
vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })
require("fzf-lua").setup({})

vim.keymap.set("n", "<leader>f", function()
	require("fzf-lua").files()
end, { desc = "files" })
vim.keymap.set("n", "<leader>g", function()
	require("fzf-lua").live_grep()
end, { desc = "grep" })
vim.keymap.set("n", "<leader>G", function()
	require("fzf-lua").grep_project()
end, { desc = "grep project" })
vim.keymap.set("n", "<leader>u", function()
	require("fzf-lua").undotree()
end, { desc = "undo tree" })
vim.keymap.set("n", "<leader>h", function()
	require("fzf-lua").help_tags()
end, { desc = "help tags" })
vim.keymap.set("n", "<leader>d", function()
	require("fzf-lua").diagnostics_document()
end, { desc = "diagnostic" })
vim.keymap.set("n", "<leader>D", function()
	require("fzf-lua").diagnostics_workspace()
end, { desc = "diagnostic workspace" })

-- =============================================================================
-- 12. DIAGNOSTICS  (noice + inline diagnostics; nui from section 3)
-- =============================================================================
vim.pack.add({ "https://github.com/folke/noice.nvim" })
require("noice").setup({ cmdline = { enabled = false } })

vim.pack.add({ "https://github.com/rachartier/tiny-inline-diagnostic.nvim" })
require("tiny-inline-diagnostic").setup({
	options = {
		multilines = { enabled = true, always_show = true },
	},
})
vim.diagnostic.config({ virtual_text = false })

-- =============================================================================
-- 13. ANIMATIONS  (tiny-glimmer)
-- =============================================================================
vim.pack.add({ "https://github.com/rachartier/tiny-glimmer.nvim" })
require("tiny-glimmer").setup({
	overwrite = {
		yank = { enabled = true, default_animation = "fade" },
		paste = { enabled = true, default_animation = "fade" },
		search = { enabled = true, default_animation = "fade" },
		undo = { enabled = true, default_animation = "fade" },
		redo = { enabled = true, default_animation = "fade" },
	},
	animations = {
		fade = { max_duration = 500, min_duration = 50, lingering_time = 0 },
	},
})

-- =============================================================================
-- 14. CODE ACTION  (tiny-code-action, uses fzf-lua as picker)
-- =============================================================================
vim.pack.add({ "https://github.com/rachartier/tiny-code-action.nvim" })
require("tiny-code-action").setup({ picker = { "fzf-lua" } })
vim.keymap.set("n", "<leader>a", function()
	require("tiny-code-action").code_action()
end, { desc = "Code action" })

-- =============================================================================
-- 15. NOTIFICATIONS  (fidget + nvim-notify; nui from section 3)
-- =============================================================================
vim.pack.add({
	"https://github.com/j-hui/fidget.nvim",
	"https://github.com/rcarriga/nvim-notify",
})
require("notify").setup({ render = "wrapped-compact" })
vim.notify = require("notify")
require("fidget").setup({})

-- =============================================================================
-- 16. FILE MANAGER  (oil)
-- =============================================================================
vim.pack.add({ "https://github.com/stevearc/oil.nvim" })
require("oil").setup({
	view_options = { show_hidden = true },
})
vim.keymap.set("n", "<leader>e", function()
	require("oil").open()
end, { desc = "Open oil" })

-- =============================================================================
-- 17. TEXT OBJECTS  (mini.ai + treesitter textobjects; treesitter from §6)
-- =============================================================================
vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
})
require("mini.ai").setup({
	custom_textobjects = {
		F = require("mini.ai").gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
		c = require("mini.ai").gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
		C = require("mini.ai").gen_spec.treesitter({ a = "@call.outer", i = "@call.inner" }),
		o = require("mini.ai").gen_spec.treesitter({ a = "@conditional.outer", i = "@conditional.inner" }),
		l = require("mini.ai").gen_spec.treesitter({ a = "@loop.outer", i = "@loop.inner" }),
	},
})

-- =============================================================================
-- 18. FLASH  (s = jump, R = treesitter search)
-- =============================================================================
vim.pack.add({ "https://github.com/folke/flash.nvim" })
require("flash").setup()

vim.keymap.set({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end, { desc = "Flash" })

-- =============================================================================
-- 19. FOLDING  (nvim-ufo; fold options set in section 1)
-- =============================================================================
vim.pack.add({
	"https://github.com/kevinhwang91/nvim-ufo",
	"https://github.com/kevinhwang91/promise-async",
})
require("ufo").setup({
	provider_selector = function()
		return { "treesitter", "indent" }
	end,
})
vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
vim.keymap.set("n", "zK", require("ufo").peekFoldedLinesUnderCursor)

-- ai COMPLETION (Ollama / Qwen-based: pharo-llm/Qwen2.5-Coder-SFT:1.5B)
vim.pack.add({ "https://github.com/milanglacier/minuet-ai.nvim" })
require("minuet").setup({
	provider = "openai_fim_compatible",
	n_completions = 1,
	context_window = 4096,
	request_timeout = 4,
	provider_options = {
		openai_fim_compatible = {
			api_key = "TERM",
			name = "Ollama",
			end_point = "http://localhost:11434/v1/completions",
			model = "pharo-llm/Qwen2.5-Coder-SFT:1.5B",
			stream = false,
			optional = {
				max_tokens = 96,
				temperature = 0,
				top_p = 0.9,
			},
		},
	},
	virtualtext = {
		auto_trigger_ft = { "*" },
		keymap = {
			accept = "<A-A>",
			accept_line = "<A-a>",
			accept_n_lines = "<A-z>",
			prev = "<A-[>",
			next = "<A-]>",
			dismiss = "<A-e>",
		},
	},
})
