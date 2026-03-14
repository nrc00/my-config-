-- ╔══════════════════════════════════════════════════════════════════════════╗
-- ║                        NEOVIM CONFIGURATION                             ║
-- ║              Compatible with Neovim 0.11+ and 0.12+                     ║
-- ╚══════════════════════════════════════════════════════════════════════════╝

-- =============================================================================
-- PROVIDERS
-- =============================================================================
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider    = 0
vim.g.loaded_perl_provider    = 0
vim.g.loaded_node_provider    = 0

-- =============================================================================
-- LEADER
-- =============================================================================
vim.g.mapleader               = " "
vim.g.maplocalleader          = " "

-- =============================================================================
-- CORE OPTIONS
-- =============================================================================
local opt                     = vim.opt

-- Appearance
opt.termguicolors             = true
opt.number                    = true
opt.relativenumber            = true
opt.wrap                      = false
opt.scrolloff                 = 8
opt.sidescrolloff             = 16

-- Indentation
opt.tabstop                   = 2
opt.shiftwidth                = 2
opt.expandtab                 = true

-- Search
opt.ignorecase                = true
opt.smartcase                 = true

-- Files & History
opt.undofile                  = true
opt.autoread                  = true
-- NOTE: clipboard is now managed manually via keymaps, not global setting
-- opt.clipboard                 = "unnamedplus"

-- =============================================================================
-- CLIPBOARD FUNCTIONS (System vs Internal)
-- =============================================================================

-- System clipboard operations (using + register)
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste before from system clipboard" })

-- Internal Neovim clipboard (using 0 register - last yank)
-- Default yank/paste stays internal (unnamed register)
vim.keymap.set({ "n", "v" }, "y", "y", { desc = "Yank (internal)" })
vim.keymap.set({ "n", "v" }, "p", "p", { desc = "Paste (internal)" })
vim.keymap.set({ "n", "v" }, "P", "P", { desc = "Paste before (internal)" })

-- Quick paste from yank register (explicit)
vim.keymap.set({ "n", "v" }, "<leader>ip", '"0p', { desc = "Paste from internal yank" })
vim.keymap.set({ "n", "v" }, "<leader>iP", '"0P', { desc = "Paste before from internal yank" })

-- =============================================================================
-- AUTOCMDS
-- =============================================================================

-- Flash yanked region
vim.api.nvim_create_autocmd("TextYankPost", {
  group    = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  desc     = "Flash yanked region",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

-- Open :help in vertical split
vim.api.nvim_create_autocmd("FileType", {
  pattern  = "help",
  callback = function() vim.cmd("wincmd L") end,
})

-- =============================================================================
-- BOOTSTRAP LAZY.NVIM
-- =============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

-- =============================================================================
-- PLUGINS
-- =============================================================================
require("lazy").setup({
  spec = {

    -- ┌─────────────────────────────────────────────────────────────────────┐
    -- │  APPEARANCE                                                         │
    -- └─────────────────────────────────────────────────────────────────────┘

    -- ── Colorscheme: rose-pine ───────────────────────────────────────────
    {
      "rose-pine/neovim",
      name     = "rose-pine",
      priority = 1000,
      lazy     = false,
      config   = function()
        vim.cmd("colorscheme rose-pine")
      end,
    },

    -- ── Lualine: status line ─────────────────────────────────────────────
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "echasnovski/mini.nvim" },
      opts         = {
        options  = {
          theme                = "rose-pine",
          component_separators = { left = "|", right = "|" },
          section_separators   = { left = "", right = "" },
          globalstatus         = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      },
    },

    -- ── Barbar: buffer/tab line ──────────────────────────────────────────
    {
      "romgrk/barbar.nvim",
      lazy         = false,
      dependencies = { "echasnovski/mini.nvim", "lewis6991/gitsigns.nvim" },
      version      = "^1.0.0",
      init         = function()
        vim.g.barbar_auto_setup = false
      end,
      opts         = {},
      keys         = {
        { "<Tab>",      "<cmd>BufferNext<cr>",               desc = "Next buffer" },
        { "<S-Tab>",    "<cmd>BufferPrevious<cr>",           desc = "Previous buffer" },
        { "<leader>bd", "<cmd>BufferClose<cr>",              desc = "Close buffer" },
        { "<leader>bp", "<cmd>BufferPin<cr>",                desc = "Pin buffer" },
        { "<leader>bo", "<cmd>BufferCloseAllButCurrent<cr>", desc = "Close other buffers" },
        { "<leader>bD", "<cmd>BufferCloseAllButPinned<cr>",  desc = "Close unpinned buffers" },
        { "<leader>bl", "<cmd>BufferMoveNext<cr>",           desc = "Move buffer right" },
        { "<leader>bh", "<cmd>BufferMovePrevious<cr>",       desc = "Move buffer left" },
        { "<leader>1",  "<cmd>BufferGoto 1<cr>",             desc = "Go to buffer 1" },
        { "<leader>2",  "<cmd>BufferGoto 2<cr>",             desc = "Go to buffer 2" },
        { "<leader>3",  "<cmd>BufferGoto 3<cr>",             desc = "Go to buffer 3" },
        { "<leader>4",  "<cmd>BufferGoto 4<cr>",             desc = "Go to buffer 4" },
        { "<leader>5",  "<cmd>BufferGoto 5<cr>",             desc = "Go to buffer 5" },
      },
    },

    -- ── Neominimap: file overview panel ─────────────────────────────────
    {
      "Isrothy/neominimap.nvim",
      version = "v3.x.x",
      lazy    = false,
      init    = function()
        vim.g.neominimap = { auto_enable = true }
      end,
      keys    = {
        -- make this keybinds simpler like leader mf to focus and unfocus depending whether in focus or not

        { "<leader>mt", "<cmd>Neominimap Toggle<cr>",  desc = "Toggle minimap" },
        { "<leader>mf", "<cmd>Neominimap Focus<cr>",   desc = "Focus minimap" },
        { "<leader>mu", "<cmd>Neominimap Unfocus<cr>", desc = "Unfocus minimap" },
        { "<leader>mr", "<cmd>Neominimap Refresh<cr>", desc = "Refresh minimap" },
      },
    },

    -- ┌─────────────────────────────────────────────────────────────────────┐
    -- │  SYNTAX & LANGUAGE                                                  │
    -- │  nvim-treesitter main branch (complete rewrite)                     │
    -- └─────────────────────────────────────────────────────────────────────┘

    -- ── Treesitter: parser management ─────────────────────────────────────
    -- NOTE: main branch is incompatible rewrite. setup() no longer takes
    -- ensure_installed, highlight, indent. You must manually install parsers
    -- and enable features via vim.treesitter.start()
    {
      "nvim-treesitter/nvim-treesitter",
      lazy   = false,
      branch = "main", -- Explicitly use main branch
      build  = ":TSUpdate",
      config = function()
        -- Minimal setup - only install_dir is configurable
        require("nvim-treesitter").setup({
          install_dir = vim.fn.stdpath('data') .. '/site'
        })

        -- Install parsers explicitly (async)
        -- Use :TSInstall interactively, or install here
        local parsers = {
          "c", "lua", "vim", "vimdoc", "query",
          "bash", "json", "yaml",
          "latex", "typst", "markdown", "markdown_inline", "regex",
        }

        -- Install parsers if not present (async, non-blocking)
        vim.defer_fn(function()
          for _, lang in ipairs(parsers) do
            local ok, has_parser = pcall(vim.treesitter.language.inspect, lang)
            if not ok or not has_parser then
              require("nvim-treesitter").install({ lang })
            end
          end
        end, 100)

        -- Auto-enable treesitter for all filetypes with parsers available
        vim.api.nvim_create_autocmd("FileType", {
          group = vim.api.nvim_create_augroup("treesitter_enable", { clear = true }),
          pattern = "*",
          callback = function(args)
            local buf = args.buf
            local ft = vim.bo[buf].filetype
            if not ft or ft == "" then return end

            -- Try to start treesitter if parser exists
            local ok = pcall(vim.treesitter.start, buf)
            if ok then
              -- Enable treesitter-based features
              vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
              -- foldexpr is set globally below
            end
          end,
        })

        -- Register bash for sh files
        vim.treesitter.language.register("bash", "sh")
      end,
    },

    -- ── Treesitter textobjects ──────────────────────────────────────────
    -- NOTE: textobjects also moved to main branch with new API
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      branch       = "main", -- Must match treesitter branch
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      config       = function()
        require("nvim-treesitter-textobjects").setup({
          select = {
            enable                         = true,
            lookahead                      = true,
            selection_modes                = {
              ['@parameter.outer'] = 'v',
              ['@function.outer'] = 'V',
              ['@class.outer'] = '<c-v>',
            },
            include_surrounding_whitespace = false,
          },
          move = {
            enable    = true,
            set_jumps = true,
          },
        })

        -- Manual keymap setup required in main branch
        local select = require("nvim-treesitter-textobjects.select")
        local move = require("nvim-treesitter-textobjects.move")

        -- Text objects
        vim.keymap.set({ "x", "o" }, "af", function()
          select.select_textobject("@function.outer", "textobjects")
        end, { desc = "Around function" })
        vim.keymap.set({ "x", "o" }, "if", function()
          select.select_textobject("@function.inner", "textobjects")
        end, { desc = "Inside function" })
        vim.keymap.set({ "x", "o" }, "ac", function()
          select.select_textobject("@class.outer", "textobjects")
        end, { desc = "Around class" })
        vim.keymap.set({ "x", "o" }, "ic", function()
          select.select_textobject("@class.inner", "textobjects")
        end, { desc = "Inside class" })
        vim.keymap.set({ "x", "o" }, "aa", function()
          select.select_textobject("@parameter.outer", "textobjects")
        end, { desc = "Around argument" })
        vim.keymap.set({ "x", "o" }, "ia", function()
          select.select_textobject("@parameter.inner", "textobjects")
        end, { desc = "Inside argument" })

        -- Movement
        vim.keymap.set({ "n", "x", "o" }, "]f", function()
          move.goto_next_start("@function.outer", "textobjects")
        end, { desc = "Next function start" })
        vim.keymap.set({ "n", "x", "o" }, "[f", function()
          move.goto_previous_start("@function.outer", "textobjects")
        end, { desc = "Prev function start" })
        vim.keymap.set({ "n", "x", "o" }, "]F", function()
          move.goto_next_end("@function.outer", "textobjects")
        end, { desc = "Next function end" })
        vim.keymap.set({ "n", "x", "o" }, "[F", function()
          move.goto_previous_end("@function.outer", "textobjects")
        end, { desc = "Prev function end" })
        vim.keymap.set({ "n", "x", "o" }, "]c", function()
          move.goto_next_start("@class.outer", "textobjects")
        end, { desc = "Next class start" })
        vim.keymap.set({ "n", "x", "o" }, "[c", function()
          move.goto_previous_start("@class.outer", "textobjects")
        end, { desc = "Prev class start" })
        vim.keymap.set({ "n", "x", "o" }, "]C", function()
          move.goto_next_end("@class.outer", "textobjects")
        end, { desc = "Next class end" })
        vim.keymap.set({ "n", "x", "o" }, "[C", function()
          move.goto_previous_end("@class.outer", "textobjects")
        end, { desc = "Prev class end" })
      end,
    },

    -- ── Markview: rendered markdown preview ──────────────────────────────
    {
      "OXY2DEV/markview.nvim",
      ft           = { "markdown" },
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      config       = function()
        require("markview").setup({
          modes        = { "n", "no", "c" },
          hybrid_modes = { "n" },
        })
        vim.keymap.set("n", "<leader>mv", "<cmd>Markview toggle<CR>", { desc = "Toggle markview" })
      end,
    },

    -- ┌─────────────────────────────────────────────────────────────────────┐
    -- │  EDITING                                                            │
    -- └─────────────────────────────────────────────────────────────────────┘

    -- ── Mini.nvim: pairs, surround, icons, comments, sessions ────────────
    {
      "echasnovski/mini.nvim",
      version = "*",
      config  = function()
        -- mini.pairs: auto-insert closing pairs
        require("mini.pairs").setup()

        -- Buffer-local $ pair for typst/tex (math mode)
        vim.api.nvim_create_autocmd("FileType", {
          group    = vim.api.nvim_create_augroup("mini_pairs_math", { clear = true }),
          pattern  = { "typst", "tex" },
          callback = function()
            require("mini.pairs").map_buf(
              0, "i", "$",
              { action = "openclose", pair = "$$", neigh_pattern = "[^\\$]." }
            )
          end,
        })

        -- mini.surround: DEFAULT MAPPINGS (sa, sd, sr, sf, sF, sh)
        -- Default: sa=add, sd=delete, sr=replace, sf=find right, sF=find left, sh=highlight
        -- This conflicts with flash.nvim's default 's' key, so we use a different approach:
        -- Option 1: Use mini.surround defaults (sa/sd/sr) and map flash to <CR> or other
        -- Option 2: Change mini.surround prefix (e.g., to 'gz' as before)
        --
        -- Here we use Option 1: mini.surround gets 's' prefix, flash uses '<CR>'
        require("mini.surround").setup({
          -- Using defaults: sa, sd, sr, sf, sF, sh
          -- No custom mappings needed unless you want to change them
          n_lines = 20,
          search_method = 'cover',
        })

        -- mini.icons: icon provider
        require("mini.icons").setup()
        MiniIcons.mock_nvim_web_devicons()

        -- mini.comment: gc/gcc commenting (using built-in commentstring)
        require("mini.comment").setup({
          options = {
            custom_commentstring = function()
              return vim.bo.commentstring
            end,
          },
        })

        -- mini.sessions: session management
        require("mini.sessions").setup({
          autoread  = true,
          autowrite = true,
          directory = vim.fn.stdpath("data") .. "/session",
          file      = "Session.vim",
          force     = { read = false, write = true, delete = false },
          verbose   = { read = false, write = true, delete = true },
        })

        local MS = MiniSessions

        vim.keymap.set("n", "<leader>ss", function()
          vim.ui.input({ prompt = "Session name: " }, function(name)
            if name and name ~= "" then MS.write(name) end
          end)
        end, { desc = "Save session" })

        vim.keymap.set("n", "<leader>sl", function()
          local sessions = vim.tbl_keys(MS.detected)
          if vim.tbl_isempty(sessions) then
            vim.notify("No saved sessions found.", vim.log.levels.WARN)
            return
          end
          vim.ui.select(sessions, { prompt = "Load session:" }, function(choice)
            if choice then MS.read(choice) end
          end)
        end, { desc = "Load session" })

        vim.keymap.set("n", "<leader>sd", function()
          local sessions = vim.tbl_keys(MS.detected)
          if vim.tbl_isempty(sessions) then
            vim.notify("No saved sessions found.", vim.log.levels.WARN)
            return
          end
          vim.ui.select(sessions, { prompt = "Delete session:" }, function(choice)
            if choice then MS.delete(choice, { force = true }) end
          end)
        end, { desc = "Delete session" })

        vim.keymap.set("n", "<leader>sr", function()
          MS.write(nil)
        end, { desc = "Quick-save local session" })
      end,
    },

    -- ── Blink.cmp: completion ────────────────────────────────────────────
    {
      "saghen/blink.cmp",
      dependencies = { "rafamadriz/friendly-snippets" },
      version      = "1.1.1", -- Pinned for stability
      opts         = {
        keymap     = { preset = "super-tab" },
        appearance = { nerd_font_variant = "mono" },
        completion = {
          documentation = { auto_show = true, auto_show_delay_ms = 300 },
        },
        sources    = { default = { "lsp", "path", "snippets", "buffer" } },
        fuzzy      = { implementation = "prefer_rust_with_warning" },
      },
      opts_extend  = { "sources.default" },
    },

    -- ── Conform.nvim: auto-formatting ────────────────────────────────────
    {
      "stevearc/conform.nvim",
      opts = {
        formatters_by_ft = {
          lua      = { "stylua" },
          python   = { "ruff_format", "black", stop_after_first = true },
          sh       = { "shfmt" },
          bash     = { "shfmt" },
          c        = { "clang_format" },
          cpp      = { "clang_format" },
          tex      = { "latexindent" },
          typst    = { "typstyle" },
          json     = { "jq" },
          yaml     = { "prettier" },
          markdown = { "prettier" },
          ["_"]    = { "trim_whitespace" },
        },
        format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
      },
      keys = {
        {
          "<leader>cf",
          function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
          desc = "Format buffer",
        },
      },
    },

    -- ── Typst-preview: live Typst document preview ───────────────────────
    {
      "chomosuke/typst-preview.nvim",
      ft      = "typst",
      version = "1.*",
      opts    = {
        dependencies_bin = {
          ["tinymist"] = "tinymist",
          ["websocat"] = "websocat",
        },
      },
      keys    = {
        { "<leader>tp", "<cmd>TypstPreview<cr>",     desc = "Typst preview" },
        { "<leader>ts", "<cmd>TypstPreviewSync<cr>", desc = "Sync typst preview" },
      },
    },

    -- ┌─────────────────────────────────────────────────────────────────────┐
    -- │  NAVIGATION                                                         │
    -- └─────────────────────────────────────────────────────────────────────┘

    -- ── Snacks.nvim: UI suite ────────────────────────────────────────────
    {
      "folke/snacks.nvim",
      priority = 1000,
      lazy     = false,
      opts     = {
        bigfile      = { enabled = true },
        explorer     = { enabled = true },
        indent       = { enabled = true },
        input        = { enabled = true },
        notifier     = { enabled = true },
        quickfile    = { enabled = true },
        scope        = { enabled = true },
        scroll       = { enabled = true },
        statuscolumn = { enabled = true },
        words        = { enabled = true },
        dashboard    = {
          enabled = true,
          preset  = {
            keys = {
              { icon = " ", key = "f", desc = "Find File",       action = ":lua Snacks.picker.files()" },
              { icon = " ", key = "n", desc = "New File",        action = ":ene | startinsert" },
              { icon = " ", key = "/", desc = "Find Text",       action = ":lua Snacks.picker.grep()" },
              { icon = " ", key = "r", desc = "Recent Files",    action = ":lua Snacks.picker.recent()" },
              { icon = " ", key = "c", desc = "Config",          action = ":lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })" },
              { icon = " ", key = "s", desc = "Restore Session", section = "session" },
              { icon = " ", key = "L", desc = "Lazy",            action = ":Lazy" },
              { icon = " ", key = "q", desc = "Quit",            action = ":qa" },
            },
          },
        },
        picker       = {
          enabled = true,
          actions = {
            opencode_send = function(...)
              return require("opencode").snacks_picker_send(...)
            end,
          },
          win = {
            input = {
              keys = { ["<a-a>"] = { "opencode_send", mode = { "n", "i" } } },
            },
          },
        },
      },
      keys     = {
        -- Files
        { "<leader>ff", function() Snacks.picker.files() end,              desc = "Find files" },
        { "<leader>fg", function() Snacks.picker.grep() end,               desc = "Live grep" },
        { "<leader>fb", function() Snacks.picker.buffers() end,            desc = "Find buffers" },
        { "<leader>fr", function() Snacks.picker.recent() end,             desc = "Recent files" },
        { "<leader>fh", function() Snacks.picker.help() end,               desc = "Help tags" },
        -- Explorer
        { "<leader>e",  function() Snacks.explorer() end,                  desc = "File explorer" },
        -- Diagnostics
        { "<leader>xd", function() Snacks.picker.diagnostics() end,        desc = "Workspace diagnostics" },
        { "<leader>xb", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer diagnostics" },
        -- Notifications
        { "<leader>nh", function() Snacks.notifier.show_history() end,     desc = "Notification history" },
        -- Git
        { "<leader>gl", function() Snacks.picker.git_log() end,            desc = "Git log" },
        { "<leader>gs", function() Snacks.picker.git_status() end,         desc = "Git status" },
      },
    },

    -- ── Flash.nvim: instant jumps ─────────────────────────────────────────
    -- NOTE: Default flash uses 's' which conflicts with mini.surround
    -- We use '<CR>' (Enter) for flash jump instead to avoid conflict
    {
      "folke/flash.nvim",
      event = "VeryLazy",
      opts  = {
        modes = {
          char = {
            enabled = false, -- Don't enhance f/F/t/T to avoid conflicts
          },
        },
      },
      keys  = {
        -- Use <CR> for flash jump (doesn't conflict with mini.surround's sa/sd/sr)
        { "<CR>",  mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash jump" },
        { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash treesitter" },
        { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Flash remote" },
        { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Flash treesitter search" },
        { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Flash toggle search" },
      },
    },

    -- ── Which-key: keybind discovery ─────────────────────────────────────
    { "folke/which-key.nvim", opts = { preset = "modern" } },

    -- ┌─────────────────────────────────────────────────────────────────────┐
    -- │  GIT                                                                │
    -- └─────────────────────────────────────────────────────────────────────┘

    -- ── Gitsigns: diff signs, staging, and blame ─────────────────────────
    {
      "lewis6991/gitsigns.nvim",
      event = { "BufReadPre", "BufNewFile" },
      opts  = {
        signs = {
          add          = { text = "▎" },
          change       = { text = "▎" },
          delete       = { text = "" },
          topdelete    = { text = "" },
          changedelete = { text = "▎" },
          untracked    = { text = "▎" },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
          end

          map("n", "]h", function()
            if vim.wo.diff then
              vim.cmd.normal({ "]c", bang = true })
            else
              gs.nav_hunk("next")
            end
          end, "Next hunk")

          map("n", "[h", function()
            if vim.wo.diff then
              vim.cmd.normal({ "[c", bang = true })
            else
              gs.nav_hunk("prev")
            end
          end, "Previous hunk")

          map({ "n", "v" }, "<leader>hs", gs.stage_hunk, "Stage hunk")
          map({ "n", "v" }, "<leader>hr", gs.reset_hunk, "Reset hunk")
          map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
          map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")
          map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage")
          map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
          map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
          map("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle blame")
          map("n", "<leader>hd", gs.diffthis, "Diff index")
          map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff last commit")
          map({ "o", "x" }, "ih", ":<C-u>Gitsigns select_hunk<cr>", "Select hunk")
        end,
      },
    },

    -- ┌─────────────────────────────────────────────────────────────────────┐
    -- │  AI & COMPLETIONS                                                   │
    -- └─────────────────────────────────────────────────────────────────────┘

    -- ── Opencode.nvim: AI assistant integration ──────────────────────────
    {
      "nickjvandyke/opencode.nvim",
      version      = "*",
      dependencies = { { "folke/snacks.nvim", optional = true } },
      config       = function()
        vim.g.opencode_opts = {}

        vim.keymap.set({ "n", "x" }, "<C-a>", function()
          require("opencode").ask("@this: ", { submit = true })
        end, { desc = "Ask about buffer/selection" })

        vim.keymap.set("n", "<leader>oa", function()
          require("opencode").select()
        end, { desc = "Opencode palette" })

        vim.keymap.set("n", "<leader>ot", function()
          require("opencode").open()
        end, { desc = "Opencode terminal" })

        vim.keymap.set("n", "<leader>oq", function()
          require("opencode").ask("")
        end, { desc = "Opencode question" })
      end,
    },

    -- ── Neocodeium: AI inline completion ─────────────────────────────────
    -- DISABLED by default - enable with :NeoCodeium enable or <leader>ai
    {
      "monkoose/neocodeium",
      event  = "VeryLazy",
      config = function()
        local nc = require("neocodeium")
        nc.setup({
          enabled = false, -- Start disabled by default
          silent = false
        })

        vim.keymap.set("i", "<M-l>", nc.accept, { desc = "Accept suggestion" })
        vim.keymap.set("i", "<M-w>", nc.accept_word, { desc = "Accept word" })
        vim.keymap.set("i", "<M-a>", nc.accept_line, { desc = "Accept line" })
        vim.keymap.set("i", "<M-]>", function() nc.cycle_or_complete(1) end, { desc = "Next suggestion" })
        vim.keymap.set("i", "<M-[>", function() nc.cycle_or_complete(-1) end, { desc = "Previous suggestion" })
        vim.keymap.set("i", "<M-e>", nc.clear, { desc = "Clear suggestion" })
        vim.keymap.set("n", "<leader>ai", "<cmd>NeoCodeium toggle<cr>", { desc = "Toggle AI completion" })
      end,
    },

  },

  install = { colorscheme = { "rose-pine", "habamax" } },
  checker = { enabled = true },
})

-- =============================================================================
-- LSP (Native Neovim 0.11+ API)
-- NOTE: vim.lsp.config() and vim.lsp.enable() are the new native APIs
-- =============================================================================
vim.api.nvim_create_autocmd("LspAttach", {
  group    = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
  callback = function(ev)
    local function map(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = desc })
    end

    -- Use Snacks picker for LSP if available, fallback to native
    local has_snacks = package.loaded["snacks"] ~= nil

    -- Go to definition
    map("gd", has_snacks and function() Snacks.picker.lsp_definitions() end or vim.lsp.buf.definition,
      "Go to definition")

    -- List references
    map("gr", has_snacks and function() Snacks.picker.lsp_references() end or vim.lsp.buf.references,
      "List references")

    -- Implementation and type definition
    map("gI", vim.lsp.buf.implementation, "Go to implementation")
    map("gt", vim.lsp.buf.type_definition, "Go to type definition")

    -- Hover and actions
    map("K", vim.lsp.buf.hover, "Hover documentation")
    map("<leader>ca", vim.lsp.buf.code_action, "Code actions")
    map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")

    -- Document symbols
    map("<leader>ls", has_snacks and function() Snacks.picker.lsp_symbols() end or vim.lsp.buf.document_symbol,
      "Document symbols")

    -- Call hierarchy (0.11+ API - works in both 0.11 and 0.12)
    -- NOTE: incoming_calls/outgoing_calls are deprecated in favor of call_hierarchy
    map("<leader>ci", function()
      -- Use call_hierarchy with direction "from" for incoming
      vim.lsp.buf.call_hierarchy("from")
    end, "Incoming calls")

    map("<leader>co", function()
      -- Use call_hierarchy with direction "to" for outgoing
      vim.lsp.buf.call_hierarchy("to")
    end, "Outgoing calls")

    -- Diagnostics navigation
    map("[d", function() vim.diagnostic.jump({ count = -1 }) end, "Previous diagnostic")
    map("]d", function() vim.diagnostic.jump({ count = 1 }) end, "Next diagnostic")
    map("<leader>cd", vim.diagnostic.open_float, "Diagnostic detail")
  end,
})

-- ── Server configurations ─────────────────────────────────────────────────────
local capabilities = require("blink.cmp").get_lsp_capabilities()

local servers = {
  lua_ls   = {
    cmd       = { "lua-language-server" },
    filetypes = { "lua" },
    settings  = {
      Lua = {
        runtime     = { version = "LuaJIT" },
        workspace   = { checkThirdParty = false, library = vim.api.nvim_get_runtime_file("", true) },
        diagnostics = { globals = { "vim" } },
        telemetry   = { enable = false },
      },
    },
  },
  clangd   = { cmd = { "clangd" }, filetypes = { "c", "cpp", "objc", "objcpp" } },
  pyright  = { cmd = { "pyright-langserver", "--stdio" }, filetypes = { "python" } },
  bashls   = { cmd = { "bash-language-server", "start" }, filetypes = { "sh", "bash" } },
  texlab   = { cmd = { "texlab" }, filetypes = { "tex", "bib" } },
  tinymist = {
    cmd       = { "tinymist" },
    filetypes = { "typst" },
    settings  = { exportPdf = "onSave" },
  },
}

for name, config in pairs(servers) do
  config.capabilities = capabilities
  vim.lsp.config(name, config)
end

vim.lsp.enable(vim.tbl_keys(servers))

-- ── Diagnostic display ────────────────────────────────────────────────────────
vim.diagnostic.config({
  virtual_text     = { prefix = "●" },
  signs            = true,
  underline        = true,
  update_in_insert = false,
  severity_sort    = true,
  float            = { border = "rounded", source = true },
})

-- =============================================================================
-- KEYMAPS
-- =============================================================================
local function map(mode, lhs, rhs, opts)
  opts        = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- ── Save & Quit ───────────────────────────────────────────────────────────────
map("n", "<leader>w", "<cmd>write<cr>", { desc = "Save file" })
map("n", "<leader>W", "<cmd>wall<cr>", { desc = "Save all files" })
map("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit window" })
map("n", "<leader>Q", "<cmd>qa<cr>", { desc = "Quit all" })

-- ── Window navigation ─────────────────────────────────────────────────────────
map("n", "<C-h>", "<C-w>h", { desc = "Focus left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus below window" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus above window" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus right window" })

-- ── Window resize ─────────────────────────────────────────────────────────────
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase width" })

-- ── Terminal mode ─────────────────────────────────────────────────────────────
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Terminal: left" })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Terminal: down" })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Terminal: up" })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Terminal: right" })

-- ── Terminal toggle ───────────────────────────────────────────────────────────
map("n", "<leader>tt", function()
  vim.cmd("botright 15split | terminal")
  vim.cmd("startinsert")
end, { desc = "Open terminal" })

-- ── Quick macro recording (q is taken by quit, use Q) ─────────────────────────
map("n", "Q", "q", { desc = "Record macro" })
map("n", "gQ", "@q", { desc = "Play macro" })

-- ── Clear search highlighting ─────────────────────────────────────────────────
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- ── Better indenting (stay in visual mode) ────────────────────────────────────
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- ── Move lines up/down ────────────────────────────────────────────────────────
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- ── Quick fix navigation ──────────────────────────────────────────────────────
map("n", "]q", "<cmd>cnext<cr>", { desc = "Next quickfix" })
map("n", "[q", "<cmd>cprev<cr>", { desc = "Previous quickfix" })
map("n", "]l", "<cmd>lnext<cr>", { desc = "Next loclist" })
map("n", "[l", "<cmd>lprev<cr>", { desc = "Previous loclist" })

-- ── Buffer navigation (alternative to barbar) ─────────────────────────────────
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<leader>bN", "<cmd>enew<cr>", { desc = "New buffer" })

-- ── Treesitter folding (global setting) ─────────────────────────────────────
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99 -- Start with all folds open
