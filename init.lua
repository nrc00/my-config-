-- ╔══════════════════════════════════════════════════════════════════════════╗
-- ║                        NEOVIM CONFIGURATION                             ║
-- ║              A clean, minimal setup built for productivity              ║
-- ╚══════════════════════════════════════════════════════════════════════════╝

-- =============================================================================
-- AUTO-ESCAPE TO NORMAL MODE
-- Returns to normal mode after `timeout_ms` of inactivity in insert mode.
-- Temporarily lowers `updatetime` on InsertEnter and restores it on exit
-- so the rest of neovim (autosave CursorHold, gitsigns, etc.) is unaffected.
-- =============================================================================
local auto_escape_group      = vim.api.nvim_create_augroup("auto_escape", { clear = true })
local auto_escape_timeout_ms = 3000 -- adjust to taste (milliseconds)
local original_updatetime

vim.api.nvim_create_autocmd("InsertEnter", {
  group    = auto_escape_group,
  desc     = "Lower updatetime while in insert mode for auto-escape",
  callback = function()
    original_updatetime = vim.o.updatetime
    vim.o.updatetime    = auto_escape_timeout_ms
  end,
})

vim.api.nvim_create_autocmd("CursorHoldI", {
  group    = auto_escape_group,
  desc     = "Escape to normal mode after inactivity timeout",
  callback = function() vim.cmd("stopinsert") end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  group    = auto_escape_group,
  desc     = "Restore updatetime after leaving insert mode",
  callback = function()
    if original_updatetime then
      vim.o.updatetime = original_updatetime
    end
  end,
})

-- =============================================================================
-- PROVIDERS
-- Disable unused language providers to suppress startup warnings.
-- =============================================================================
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider    = 0
vim.g.loaded_perl_provider    = 0
vim.g.loaded_node_provider    = 0

-- =============================================================================
-- LEADER
-- Space as leader for both global and buffer-local mappings.
-- Must be set before any plugin loads so keymaps bind correctly.
-- =============================================================================
vim.g.mapleader      = " "
vim.g.maplocalleader = " "

-- =============================================================================
-- CORE OPTIONS
-- =============================================================================
local opt = vim.opt

--  ── Appearance ──────────────────────────────────────────────────────────────
opt.termguicolors  = true  -- enable 24-bit RGB colour in the TUI
opt.number         = true  -- show absolute line number on the current line
opt.relativenumber = true  -- show relative line numbers for all other lines
opt.wrap           = false -- do not wrap long lines
opt.scrolloff      = 20    -- keep 20 lines visible above/below the cursor
opt.sidescrolloff  = 36    -- keep 36 columns visible left/right of the cursor

--  ── Indentation ─────────────────────────────────────────────────────────────
opt.tabstop    = 2    -- a tab character renders as 2 spaces wide
opt.shiftwidth = 2    -- >> and << shift by 2 spaces
opt.expandtab  = true -- insert spaces instead of tab characters

--  ── Search ──────────────────────────────────────────────────────────────────
opt.ignorecase = true -- case-insensitive search by default
opt.smartcase  = true -- switch to case-sensitive when query has uppercase

--  ── Files & History ─────────────────────────────────────────────────────────
opt.undofile  = true -- persist undo history across sessions
opt.autoread  = true -- reload files changed on disk (required by opencode.nvim)
opt.clipboard = ""   -- isolate neovim's clipboard from the system clipboard;
                     -- wl-clipboard config below takes full control instead

-- =============================================================================
-- WAYLAND CLIPBOARD
-- Use wl-copy/wl-paste as the clipboard provider.
--   "+"  — selection clipboard (Ctrl-C / Ctrl-V)
--   "*"  — primary clipboard   (middle-click paste)
-- =============================================================================
vim.g.clipboard = {
  name          = "wl-clipboard",
  copy          = {
    ["+"] = { "wl-copy", "--type", "text/plain" },
    ["*"] = { "wl-copy", "--primary" },
  },
  paste         = {
    ["+"] = { "wl-paste", "--no-newline" },
    ["*"] = { "wl-paste", "--primary", "--no-newline" },
  },
  cache_enabled = true,
}

-- =============================================================================
-- AUTOCMDS
-- =============================================================================

-- Flash yanked region so you can see what was copied
-- TODO(nvim-0.12): rename vim.highlight.on_yank → vim.hl.on_yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group    = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  desc     = "Flash yanked region",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

-- Open :help in a vertical split on the right instead of a horizontal split
vim.api.nvim_create_autocmd("FileType", {
  pattern  = "help",
  callback = function() vim.cmd("wincmd L") end,
})

-- =============================================================================
-- AUTOSAVE
-- Saves the current buffer automatically in three situations:
--   CursorHold   — no keypress for `updatetime` ms while in normal mode
--   ModeChanged  — every time you return to normal mode
--   BufLeave     — when you switch away from a buffer
--   FocusLost    — when the neovim window loses focus
--
-- Skips buffers that are: invalid, unmodified, unnamed, read-only,
-- or a special type (terminal, quickfix, nofile, prompt).
-- =============================================================================
local autosave_group    = vim.api.nvim_create_augroup("autosave", { clear = true })
local non_file_buftypes = { terminal = true, quickfix = true, nofile = true, prompt = true }

local function should_save(buf)
  if not vim.api.nvim_buf_is_valid(buf)     then return false end
  if not vim.bo[buf].modified               then return false end
  if vim.bo[buf].readonly                   then return false end
  if vim.fn.bufname(buf) == ""              then return false end
  if non_file_buftypes[vim.bo[buf].buftype] then return false end
  return true
end

local function save(buf)
  if should_save(buf) then
    vim.api.nvim_buf_call(buf, function() vim.cmd("silent! write") end)
  end
end

vim.api.nvim_create_autocmd("CursorHold", {
  group    = autosave_group,
  desc     = "Autosave after updatetime ms of inactivity in normal mode",
  callback = function() save(vim.api.nvim_get_current_buf()) end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
  group    = autosave_group,
  pattern  = "*:n",
  desc     = "Autosave on every return to normal mode",
  callback = function() save(vim.api.nvim_get_current_buf()) end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  group    = autosave_group,
  desc     = "Autosave when leaving a buffer or losing window focus",
  callback = function(args)
    local buf = args.buf or vim.api.nvim_get_current_buf()
    -- Defer 100 ms so plugins finish their own BufLeave/FocusLost handlers
    vim.defer_fn(function() save(buf) end, 100)
  end,
})

-- =============================================================================
-- BOOTSTRAP LAZY.NVIM
-- Clone lazy.nvim into the data directory if it isn't already present.
-- =============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- TODO(nvim-0.12): vim.loop was removed — swap to vim.uv here
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg"   },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..."                 },
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
    -- Loaded eagerly at priority 1000 so it applies before any other UI plugin.
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
    -- Uses the rose-pine theme to match the colorscheme.
    -- globalstatus = true means one status line shared across all splits.
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "echasnovski/mini.nvim" },
      opts         = {
        options  = {
          theme                = "rose-pine",
          component_separators = { left = "|", right = "|" },
          section_separators   = { left = "",  right = "" },
          globalstatus         = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { { "filename", path = 1 } }, -- path=1: show relative path
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      },
    },

    -- ── Barbar: buffer/tab line ──────────────────────────────────────────
    -- Renders open buffers as tabs at the top. Integrates with gitsigns
    -- to show diff indicators on each tab.
    --
    -- KEYBINDS:
    --   <Tab>        — go to next buffer
    --   <S-Tab>      — go to previous buffer
    --   <leader>bd   — close current buffer
    --   <leader>bp   — pin / unpin buffer (pinned survive close-all)
    --   <leader>bo   — close every buffer except the current one
    --   <leader>bD   — close all unpinned buffers
    --   <leader>bl   — shift buffer one tab slot to the right
    --   <leader>bh   — shift buffer one tab slot to the left
    --   <leader>1-5  — jump directly to buffer in tab slot 1–5
    {
      "romgrk/barbar.nvim",
      lazy         = false,
      dependencies = { "echasnovski/mini.nvim", "lewis6991/gitsigns.nvim" },
      version      = "^1.0.0",
      init         = function()
        vim.g.barbar_auto_setup = false -- configure manually via opts below
      end,
      opts         = {},
      keys         = {
        { "<Tab>",      "<cmd>BufferNext<cr>",               desc = "Go to next buffer"                              },
        { "<S-Tab>",    "<cmd>BufferPrevious<cr>",           desc = "Go to previous buffer"                          },
        { "<leader>bd", "<cmd>BufferClose<cr>",              desc = "Close current buffer"                           },
        { "<leader>bp", "<cmd>BufferPin<cr>",                desc = "Pin/unpin current buffer"                       },
        { "<leader>bo", "<cmd>BufferCloseAllButCurrent<cr>", desc = "Close every buffer except the current one"      },
        { "<leader>bD", "<cmd>BufferCloseAllButPinned<cr>",  desc = "Close all unpinned buffers"                     },
        { "<leader>bl", "<cmd>BufferMoveNext<cr>",           desc = "Shift current buffer one position to the right" },
        { "<leader>bh", "<cmd>BufferMovePrevious<cr>",       desc = "Shift current buffer one position to the left"  },
        { "<leader>1",  "<cmd>BufferGoto 1<cr>",             desc = "Jump to buffer in tab slot 1"                   },
        { "<leader>2",  "<cmd>BufferGoto 2<cr>",             desc = "Jump to buffer in tab slot 2"                   },
        { "<leader>3",  "<cmd>BufferGoto 3<cr>",             desc = "Jump to buffer in tab slot 3"                   },
        { "<leader>4",  "<cmd>BufferGoto 4<cr>",             desc = "Jump to buffer in tab slot 4"                   },
        { "<leader>5",  "<cmd>BufferGoto 5<cr>",             desc = "Jump to buffer in tab slot 5"                   },
      },
    },

    -- ── Neominimap: file overview panel ─────────────────────────────────
    -- Renders a small overview map of the file in a side column.
    -- auto_enable = true turns it on for every buffer automatically.
    --
    -- KEYBINDS:
    --   <leader>mt   — toggle minimap on / off
    --   <leader>mf   — move cursor into the minimap panel
    --   <leader>mu   — return focus from minimap back to the editor
    --   <leader>mr   — force-refresh minimap content
    {
      "Isrothy/neominimap.nvim",
      version = "v3.x.x",
      lazy    = false,
      init    = function()
        vim.g.neominimap = { auto_enable = true }
      end,
      keys    = {
        { "<leader>mt", "<cmd>Neominimap Toggle<cr>",  desc = "Toggle minimap"                      },
        { "<leader>mf", "<cmd>Neominimap Focus<cr>",   desc = "Move cursor into minimap"            },
        { "<leader>mu", "<cmd>Neominimap Unfocus<cr>", desc = "Return focus from minimap to editor" },
        { "<leader>mr", "<cmd>Neominimap Refresh<cr>", desc = "Force-refresh minimap content"       },
      },
    },

    -- ┌─────────────────────────────────────────────────────────────────────┐
    -- │  SYNTAX & LANGUAGE                                                  │
    -- └─────────────────────────────────────────────────────────────────────┘

    -- ── Treesitter: syntax highlighting & indentation ────────────────────
    -- Parses source files into concrete syntax trees for accurate highlighting.
    -- :TSUpdate keeps all parsers up to date after lazy updates.
    {
      "nvim-treesitter/nvim-treesitter",
      lazy  = false,
      build = ":TSUpdate",
      opts  = {
        ensure_installed = {
          "c", "lua", "vim", "vimdoc", "query",
          "bash", "json", "yaml",
          "latex", "typst", "markdown", "markdown_inline", "regex",
        },
        highlight = { enable = true },
        indent    = { enable = true },
      },
      -- TODO(nvim-0.12): nvim-treesitter v1+ dropped setup() entirely.
      --   Remove the require("nvim-treesitter").setup(opts) call and let lazy
      --   apply opts automatically. Keep only the language.register line:
      --
      --   config = function(_, opts)
      --     vim.treesitter.language.register("bash", "sh")
      --   end,
      config = function(_, opts)
        require("nvim-treesitter").setup(opts)
        vim.treesitter.language.register("bash", "sh") -- treat .sh files as bash
      end,
    },

    -- ── Treesitter textobjects: function/class/argument motions ─────────
    -- Adds text objects and jump motions powered by the treesitter parse tree
    -- rather than fragile regex patterns.
    --
    -- TEXT OBJECTS (visual / operator-pending):
    --   af / if  — around / inside function   (e.g. daf deletes whole function)
    --   ac / ic  — around / inside class
    --   aa / ia  — around / inside argument   (aa includes the comma)
    --
    -- MOTIONS (normal mode):
    --   ]f / [f  — start of next / previous function
    --   ]F / [F  — end   of next / previous function
    --   ]c / [c  — start of next / previous class
    --   ]C / [C  — end   of next / previous class
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      branch       = "main",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      opts         = {
        select = {
          enable    = true,
          lookahead = true,              -- jump forward to the next match automatically
          keymaps   = {
            ["af"] = "@function.outer",  -- around function (including signature)
            ["if"] = "@function.inner",  -- inside function body only
            ["ac"] = "@class.outer",     -- around class
            ["ic"] = "@class.inner",     -- inside class body
            ["aa"] = "@parameter.outer", -- around argument (includes the comma)
            ["ia"] = "@parameter.inner", -- inside argument value only
          },
        },
        move = {
          enable              = true,
          set_jumps           = true, -- add positions to the jumplist
          goto_next_start     = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
          goto_next_end       = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
          goto_previous_end   = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
        },
      },
      config       = function(_, opts)
        require("nvim-treesitter-textobjects").setup(opts)
      end,
    },

    -- ── Markview: rendered markdown preview ──────────────────────────────
    -- Renders markdown in-buffer with beautiful formatting in normal mode.
    --
    -- KEYBINDS:
    --   <leader>mv   — toggle markview rendering on / off
    {
      "OXY2DEV/markview.nvim",
      ft           = { "markdown" },
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      config       = function()
        require("markview").setup({
          modes        = { "n", "no", "c" },
          hybrid_modes = { "n" },
        })
        vim.keymap.set("n", "<leader>mv", "<cmd>Markview toggle<CR>", { desc = "Toggle markview rendering" })
      end,
    },

    -- ┌─────────────────────────────────────────────────────────────────────┐
    -- │  EDITING                                                            │
    -- └─────────────────────────────────────────────────────────────────────┘

    -- ── Mini.nvim: a collection of focused editing plugins ───────────────
    -- Single repo containing: pairs, surround, icons, comments, and sessions.
    --
    -- PAIRS:
    --   Handles (, [, {, ", ', ` globally (built-in defaults).
    --   $ is added as a buffer-local pair for typst and tex files so that
    --   typing $ inserts $│$ with the cursor between them (math mode).
    --
    -- SURROUND KEYBINDS (prefixed gz to avoid flash.nvim conflict):
    --   gza<motion>  — add surrounding    (e.g. gzaiw" wraps word in quotes)
    --   gzd<motion>  — delete surrounding (e.g. gzd" removes nearest quotes)
    --   gzr          — replace surrounding
    --   gzf / gzF    — find right / left surrounding
    --   gzh          — highlight surrounding
    --   gzn          — update n_lines search range
    --
    -- COMMENT KEYBINDS:
    --   gcc          — toggle line comment
    --   gc<motion>   — toggle comment over motion (e.g. gcip comments paragraph)
    --
    -- SESSION KEYBINDS:
    --   <leader>ss   — save current session (prompts for name)
    --   <leader>sl   — load a saved session (fuzzy picker)
    --   <leader>sd   — delete a saved session (fuzzy picker)
    --   <leader>sr   — quick-save local (cwd) Session.vim
    {
      "echasnovski/mini.nvim",
      version = "*",
      config  = function()

        -- ── mini.pairs ───────────────────────────────────────────────────
        -- Use all built-in defaults: (, [, {, ", ', `.
        -- $ is intentionally omitted here and added per-buffer below so it
        -- only activates in math-oriented filetypes.
        require("mini.pairs").setup()

        -- Buffer-local $…$ pair for typst and tex (inline math delimiter).
        -- neigh_pattern "[^\\$]." means:
        --   [^\\$] — character before cursor is not \ (literal escape) or $
        --            (already inside a pair), preventing double-insertion.
        --   .      — character after cursor is anything (permissive right side).
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

        -- ── mini.surround ────────────────────────────────────────────────
        -- Surround text objects: add / delete / replace surrounding characters.
        -- Remapped to gz prefix to avoid conflicting with flash.nvim's s/S.
        require("mini.surround").setup({
          mappings = {
            add            = "gza", -- add surrounding
            delete         = "gzd", -- delete surrounding
            find           = "gzf", -- find right surrounding
            find_left      = "gzF", -- find left surrounding
            highlight      = "gzh", -- highlight surrounding
            replace        = "gzr", -- replace surrounding
            update_n_lines = "gzn", -- update n_lines search range
          },
        })

        -- ── mini.icons ───────────────────────────────────────────────────
        -- Icon provider — mocks nvim-web-devicons so dependent plugins work
        -- without installing the actual devicons plugin.
        require("mini.icons").setup()
        MiniIcons.mock_nvim_web_devicons()

        -- ── mini.comment ─────────────────────────────────────────────────
        -- gc / gcc commenting with treesitter-aware comment strings.
        require("mini.comment").setup({
          options = {
            custom_commentstring = function()
              return require("ts_context_commentstring.internal").calculate_commentstring()
                  or vim.bo.commentstring
            end,
          },
        })

        -- ── mini.sessions ────────────────────────────────────────────────
        -- Lightweight session management. Sssions are stored in the
        -- default data directory (~/.local/share/nvim/session/).
        -- autoread  = true  → on a bare `nvim` launch (no file args), restore
        --                      the local session for cwd if one exists, else
        --                      restore the most recently written global session.
        -- autowrite = true  → write the currently active session on VimLeavePre
        --                      so you never lose your layout.
        -- force.delete      → require explicit confirmation before deleting.
        require("mini.sessions").setup({
          autoread  = true,                                  -- auto-restore session on bare nvim launch
          autowrite = true,                                  -- auto-persist session on exit
          directory = vim.fn.stdpath("data") .. "/session", -- global session storage
          file      = "Session.vim",                        -- local session filename (cwd-relative)
          force     = { read = false, write = true, delete = false },
          verbose   = { read = false, write = true, delete = true },
        })

        -- MiniSessions is the global object created by mini.sessions.setup()
        local MS = MiniSessions

        -- <leader>ss — save a named global session (prompts for a name)
        vim.keymap.set("n", "<leader>ss", function()
          vim.ui.input({ prompt = "Session name: " }, function(name)
            if name and name ~= "" then MS.write(name) end
          end)
        end, { desc = "Session: save with name" })

        -- <leader>sl — load a session chosen from the detected list
        vim.keymap.set("n", "<leader>sl", function()
          local sessions = vim.tbl_keys(MS.detected)
          if vim.tbl_isempty(sessions) then
            vim.notify("No saved sessions found.", vim.log.levels.WARN)
            return
          end
          vim.ui.select(sessions, { prompt = "Load session:" }, function(choice)
            if choice then MS.read(choice) end
          end)
        end, { desc = "Session: load from list" })

        -- <leader>sd — delete a session chosen from the detected list
        vim.keymap.set("n", "<leader>sd", function()
          local sessions = vim.tbl_keys(MS.detected)
          if vim.tbl_isempty(sessions) then
            vim.notify("No saved sessions found.", vim.log.levels.WARN)
            return
          end
          vim.ui.select(sessions, { prompt = "Delete session:" }, function(choice)
            if choice then MS.delete(choice, { force = true }) end
          end)
        end, { desc = "Session: delete from list" })

        -- <leader>sr — quick-save: write the local (cwd) Session.vim immediately
        vim.keymap.set("n", "<leader>sr", function()
          MS.write(nil) -- nil → writes to the configured `file` (local session)
        end, { desc = "Session: quick-save local session" })

      end,
    },

    -- ── ts-context-commentstring ─────────────────────────────────────────
    -- Provides the correct comment syntax for embedded languages (e.g. JSX
    -- inside a .tsx file). Used by mini.comment above; autocmd disabled
    -- because mini.comment calls it manually.
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      lazy = true,
      opts = { enable_autocmd = false },
    },

    -- ── Blink.cmp: LSP / snippet / buffer popup completion ───────────────
    -- Ghost-text AI completion (Neocodeium) is kept separate and NOT wired
    -- into blink, keeping the two systems independent.
    --
    -- KEYBINDS (insert mode, preset = "default"):
    --   <C-n> / <C-p>  — navigate down / up through suggestions
    --   <CR>           — confirm selected suggestion
    --   <C-e>          — close the completion menu
    --   <C-space>      — manually trigger completion
    {
      "saghen/blink.cmp",
      dependencies = { "rafamadriz/friendly-snippets" },
      version      = "1.*",
      opts         = {
        keymap     = { preset = "default" },
        appearance = { nerd_font_variant = "mono" },
        completion = {
          documentation = { auto_show = true, auto_show_delay_ms = 300 },
        },
        sources    = { default = { "lsp", "path", "snippets", "buffer" } },
        fuzzy      = { implementation = "prefer_rust_with_warning" },
      },
      opts_extend  = { "sources.default" },
    },

    -- ── Conform.nvim: auto-formatting on save ────────────────────────────
    -- Each filetype maps to one or more formatters; stop_after_first means
    -- the first available formatter wins.
    --
    -- KEYBINDS:
    --   <leader>cf   — manually trigger async format for the current buffer
    {
      "stevearc/conform.nvim",
      opts = {
        formatters_by_ft = {
          lua      = { "stylua"                                        },
          python   = { "ruff_format", "black", stop_after_first = true },
          sh       = { "shfmt"                                         },
          bash     = { "shfmt"                                         },
          c        = { "clang_format"                                  },
          cpp      = { "clang_format"                                  },
          tex      = { "latexindent"                                   },
          typst    = { "typstyle"                                      },
          json     = { "jq"                                            },
          yaml     = { "prettier"                                      },
          markdown = { "prettier"                                      },
          ["_"]    = { "trim_whitespace" }, -- fallback for any unmatched filetype
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
    -- Only loads for .typ files (ft=typst). Uses system-installed tinymist
    -- and websocat instead of downloading its own binaries.
    --
    -- KEYBINDS (typst files only):
    --   <leader>tp   — open live preview in browser
    --   <leader>ts   — sync browser scroll position to cursor location
    {
      "chomosuke/typst-preview.nvim",
      ft      = "typst",
      version = "1.*",
      build   = ":", -- skip the plugin's own binary download step
      opts    = {
        dependencies_bin = {
          ["tinymist"] = "tinymist", -- must be on $PATH
          ["websocat"] = "websocat", -- must be on $PATH
        },
      },
      keys    = {
        { "<leader>tp", "<cmd>TypstPreview<cr>",     desc = "Open Typst live preview in browser"       },
        { "<leader>ts", "<cmd>TypstPreviewSync<cr>", desc = "Sync browser preview to cursor position"  },
      },
    },

    -- ┌─────────────────────────────────────────────────────────────────────┐
    -- │  NAVIGATION                                                         │
    -- └─────────────────────────────────────────────────────────────────────┘

    -- ── Snacks.nvim: UI suite ────────────────────────────────────────────
    -- Fuzzy picker, file explorer, dashboard, indent guides, smooth scroll,
    -- word highlights, notifications, and more — all in one plugin.
    --
    -- PICKER KEYBINDS:
    --   <leader>ff   — find files in cwd
    --   <leader>fg   — live grep in cwd
    --   <leader>fb   — list open buffers
    --   <leader>fr   — recently opened files
    --   <leader>fh   — search help tags
    --   <leader>e    — toggle file explorer
    --   <leader>xd   — all workspace diagnostics
    --   <leader>xb   — diagnostics in current buffer
    --   <leader>nh   — notification history
    --   <leader>gl   — git log browser
    --   <leader>gs   — git status browser
    --
    -- LSP PICKER KEYBINDS (also see LspAttach section):
    --   gd           — go to definition
    --   gr           — list all references
    --   gI           — go to implementation
    --   gt           — go to type definition
    --   <leader>ls   — list document symbols
    --
    -- PICKER ITEM ACTION:
    --   <A-a>        — send focused item to opencode as context
    {
      "folke/snacks.nvim",
      priority = 1000,
      lazy     = false,
      opts     = {
        bigfile      = { enabled = true }, -- disable heavy features for large files
        explorer     = { enabled = true }, -- file tree with dotfile support
        indent       = { enabled = true }, -- animated indent guides
        input        = { enabled = true }, -- nicer vim.ui.input popup (used by opencode.nvim)
        notifier     = { enabled = true }, -- floating notification UI
        quickfile    = { enabled = true }, -- faster rendering for startup files
        scope        = { enabled = true }, -- highlights current scope in indent guide
        scroll       = { enabled = true }, -- smooth scrolling
        statuscolumn = { enabled = true }, -- richer sign/fold/number column
        words        = { enabled = true }, -- highlight all occurrences of word under cursor
        dashboard    = {
          enabled = true,
          preset  = {
            keys = {
              { icon = " ", key = "f", desc = "Find File",       action = ":lua Snacks.picker.files()"                                  },
              { icon = " ", key = "n", desc = "New File",        action = ":ene | startinsert"                                           },
              { icon = " ", key = "/", desc = "Find Text",       action = ":lua Snacks.picker.grep()"                                    },
              { icon = " ", key = "r", desc = "Recent Files",    action = ":lua Snacks.picker.recent()"                                  },
              { icon = " ", key = "c", desc = "Config",          action = ":lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })" },
              { icon = " ", key = "s", desc = "Restore Session", section = "session"                                                     },
              { icon = "󰒲 ", key = "L", desc = "Lazy",            action = ":Lazy"                                                       },
              { icon = " ", key = "q", desc = "Quit",            action = ":qa"                                                          },
            },
          },
        },
        picker       = {
          enabled = true,
          -- opencode_send lets you press <A-a> on any picker item to send
          -- it to opencode as context. Registered here; opencode.nvim uses it.
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
        { "<leader>ff", function() Snacks.picker.files() end,                desc = "Find files in cwd"                         },
        { "<leader>fg", function() Snacks.picker.grep() end,                 desc = "Live grep in cwd"                          },
        { "<leader>fb", function() Snacks.picker.buffers() end,              desc = "List open buffers"                         },
        { "<leader>fr", function() Snacks.picker.recent() end,               desc = "List recently opened files"                },
        { "<leader>fh", function() Snacks.picker.help() end,                 desc = "Search help tags"                          },
        -- Explorer
        { "<leader>e",  function() Snacks.explorer() end,                    desc = "Toggle file explorer"                      },
        -- Diagnostics
        { "<leader>xd", function() Snacks.picker.diagnostics() end,          desc = "List all workspace diagnostics"            },
        { "<leader>xb", function() Snacks.picker.diagnostics_buffer() end,   desc = "List diagnostics in current buffer"        },
        -- LSP (also defined in LspAttach autocmd; these use the picker UI)
        { "gd",         function() Snacks.picker.lsp_definitions() end,      desc = "Go to definition"                          },
        { "gr",         function() Snacks.picker.lsp_references() end,       desc = "List all references"                       },
        { "gI",         function() Snacks.picker.lsp_implementations() end,  desc = "Go to implementation"                      },
        { "gt",         function() Snacks.picker.lsp_type_definitions() end, desc = "Go to type definition"                     },
        { "<leader>ls", function() Snacks.picker.lsp_symbols() end,          desc = "List LSP document symbols"                 },
        -- Notifications
        { "<leader>nh", function() Snacks.notifier.show_history() end,       desc = "Show notification history"                 },
        -- Git
        { "<leader>gl", function() Snacks.picker.git_log() end,              desc = "Browse git log"                            },
        { "<leader>gs", function() Snacks.picker.git_status() end,           desc = "Browse git status (staged/unstaged files)" },
      },
    },

    -- ── Flash.nvim: instant on-screen jumps ──────────────────────────────
    -- Type s + hint chars to jump anywhere on screen instantly.
    -- Also integrates with / search and operator-pending mode.
    --
    -- KEYBINDS:
    --   s            (n/x/o) — jump to any visible position by label chars
    --   S            (n/x/o) — select / jump to a whole treesitter node
    --   r            (o)     — remotely execute operator on a flash label target
    --   R            (o/x)   — treesitter-node search across the whole file
    --   <C-s>        (c)     — toggle flash label overlay while in / search
    {
      "folke/flash.nvim",
      event = "VeryLazy",
      opts  = {},
      keys  = {
        { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash: jump to label"           },
        { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash: select treesitter node"  },
        { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Flash: remote operator target"  },
        { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Flash: treesitter search"       },
        { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Flash: toggle labels in search" },
      },
    },

    -- ── Which-key: keybind discovery popup ───────────────────────────────
    -- Shows available keybinds when you pause mid-chord, using the desc
    -- fields defined throughout this config.
    { "folke/which-key.nvim", opts = { preset = "modern" } },

    -- ┌─────────────────────────────────────────────────────────────────────┐
    -- │  GIT                                                                │
    -- └─────────────────────────────────────────────────────────────────────┘

    -- ── Gitsigns: diff signs, staging, and blame ─────────────────────────
    -- Shows git diff indicators in the sign column and provides hunk-level
    -- staging, resetting, diffing, and blame directly from the buffer.
    --
    -- HUNK NAVIGATION:
    --   ]h / [h      — jump to next / previous hunk
    --
    -- STAGING:
    --   <leader>hs   (n/v) — stage hunk under cursor
    --   <leader>hr   (n/v) — reset hunk to HEAD
    --   <leader>hS   (n)   — stage entire buffer
    --   <leader>hR   (n)   — reset entire buffer to HEAD
    --   <leader>hu   (n)   — undo last stage_hunk call
    --   <leader>hp   (n)   — preview hunk diff in a float
    --
    -- BLAME:
    --   <leader>hb   (n)   — show full blame popup for current line
    --   <leader>hB   (n)   — toggle inline blame on current line
    --
    -- DIFF:
    --   <leader>hd   (n)   — diff buffer against index
    --   <leader>hD   (n)   — diff buffer against last commit (~)
    --
    -- TEXT OBJECT:
    --   ih           (o/x) — select the hunk under cursor
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

          -- Hunk navigation (falls back to ]c/[c in diff mode)
          map("n", "]h", function()
            if vim.wo.diff then vim.cmd.normal({ "]c", bang = true })
            else gs.nav_hunk("next") end
          end, "Next hunk")

          map("n", "[h", function()
            if vim.wo.diff then vim.cmd.normal({ "[c", bang = true })
            else gs.nav_hunk("prev") end
          end, "Previous hunk")

          -- Staging
          map({ "n", "v" }, "<leader>hs", gs.stage_hunk,    "Stage hunk under cursor"         )
          map({ "n", "v" }, "<leader>hr", gs.reset_hunk,    "Reset hunk to HEAD"               )
          map("n", "<leader>hS", gs.stage_buffer,           "Stage entire buffer"              )
          map("n", "<leader>hR", gs.reset_buffer,           "Reset entire buffer to HEAD"      )
          map("n", "<leader>hu", gs.undo_stage_hunk,        "Undo last stage_hunk call"        )
          map("n", "<leader>hp", gs.preview_hunk,           "Preview hunk diff in float"       )

          -- Blame
          map("n", "<leader>hb", function() gs.blame_line({ full = true }) end,
            "Show full blame for current line")
          map("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle inline blame on current line")

          -- Diff
          map("n", "<leader>hd", gs.diffthis,               "Diff buffer against index"        )
          map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff buffer against last commit")

          -- Text object: select the hunk under cursor
          map({ "o", "x" }, "ih", ":<C-u>Gitsigns select_hunk<cr>", "Select hunk as text object")
        end,
      },
    },

    -- ┌─────────────────────────────────────────────────────────────────────┐
    -- │  AI & COMPLETIONS                                                   │
    -- └─────────────────────────────────────────────────────────────────────┘

    -- ── Opencode.nvim: AI assistant integration ──────────────────────────
    -- Integrates the opencode AI assistant with Neovim. Requires `opencode`
    -- to be installed and available on $PATH.
    --
    -- KEYBINDS:
    --   <C-a>        (n/x) — ask about current buffer / visual selection
    --   <leader>oa   (n)   — open command palette (all opencode actions)
    --   <leader>ot   (n)   — open / focus the embedded opencode terminal
    --   <leader>oq   (n)   — free-form question (no automatic context)
    --
    -- In any snacks picker, <A-a> sends the focused item to opencode.
    -- Run :checkhealth opencode after install to verify the setup.
    {
      "nickjvandyke/opencode.nvim",
      version      = "*",
      dependencies = { { "folke/snacks.nvim", optional = true } },
      config       = function()
        ---@type opencode.Opts
        vim.g.opencode_opts = {}

        vim.keymap.set({ "n", "x" }, "<C-a>", function()
          require("opencode").ask("@this: ", { submit = true })
        end, { desc = "Opencode: ask about current buffer / selection" })

        vim.keymap.set("n", "<leader>oa", function()
          require("opencode").select()
        end, { desc = "Opencode: command palette" })

        vim.keymap.set("n", "<leader>ot", function()
          require("opencode").open()
        end, { desc = "Opencode: open terminal" })

        vim.keymap.set("n", "<leader>oq", function()
          require("opencode").ask("")
        end, { desc = "Opencode: free-form question" })
      end,
    },

    -- ── Neocodeium: AI inline ghost-text completion ───────────────────────
    -- Intentionally kept separate from blink.cmp so the two systems use
    -- distinct keybinds and never interfere with each other.
    --
    -- KEYBINDS (insert mode only):
    --   <M-l>        — accept full ghost-text suggestion
    --   <M-w>        — accept next word only
    --   <M-a>        — accept next line only
    --   <M-]>        — cycle to next suggestion
    --   <M-[>        — cycle to previous suggestion
    --   <M-e>        — dismiss current suggestion
    --
    -- NORMAL MODE:
    --   <leader>ai   — toggle Neocodeium on / off
    {
      "monkoose/neocodeium",
      event  = "InsertEnter",
      config = function()
        local nc = require("neocodeium")
        nc.setup({ silent = false }) -- show notification on auth errors

        vim.keymap.set("i", "<M-l>", nc.accept,                              { desc = "Neocodeium: accept suggestion"   })
        vim.keymap.set("i", "<M-w>", nc.accept_word,                         { desc = "Neocodeium: accept next word"    })
        vim.keymap.set("i", "<M-a>", nc.accept_line,                         { desc = "Neocodeium: accept next line"    })
        vim.keymap.set("i", "<M-]>", function() nc.cycle_or_complete(1)  end, { desc = "Neocodeium: next suggestion"     })
        vim.keymap.set("i", "<M-[>", function() nc.cycle_or_complete(-1) end, { desc = "Neocodeium: previous suggestion" })
        vim.keymap.set("i", "<M-e>", nc.clear,                               { desc = "Neocodeium: dismiss suggestion"  })
        vim.keymap.set("n", "<leader>ai", "<cmd>NeoCodeium toggle<cr>",      { desc = "Toggle Neocodeium ghost text"    })
      end,
    },

  }, -- end spec

  install = { colorscheme = { "rose-pine", "habamax" } },
  checker = { enabled = true }, -- notify when plugin updates are available
})

-- =============================================================================
-- LSP  (Native Neovim 0.11 API)
-- vim.lsp.config / vim.lsp.enable replaces lspconfig entirely.
--
-- KEYBINDS (active when an LSP attaches to a buffer):
--   K            — show hover documentation float
--   <leader>ca   — list available code actions
--   <leader>rn   — rename symbol under cursor
--   <leader>ci   — list incoming calls to the symbol
--   <leader>co   — list outgoing calls from the symbol
--   [d / ]d      — jump to previous / next diagnostic
--   <leader>cd   — show diagnostic detail in a float
-- =============================================================================
vim.api.nvim_create_autocmd("LspAttach", {
  group    = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
  callback = function(ev)
    local function map(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
    end

    map("K",          vim.lsp.buf.hover,        "Show hover documentation"        )
    map("<leader>ca", vim.lsp.buf.code_action,  "List available code actions"     )
    map("<leader>rn", vim.lsp.buf.rename,       "Rename symbol under cursor"      )

    -- TODO(nvim-0.12): vim.lsp.buf.incoming_calls and outgoing_calls are
    --   removed. Replace both with vim.lsp.buf.call_hierarchy:
    --   map("<leader>ci", function() vim.lsp.buf.call_hierarchy("from") end, "List incoming calls")
    --   map("<leader>co", function() vim.lsp.buf.call_hierarchy("to")   end, "List outgoing calls")
    map("<leader>ci", vim.lsp.buf.incoming_calls, "List incoming calls to symbol"  )
    map("<leader>co", vim.lsp.buf.outgoing_calls, "List outgoing calls from symbol")

    map("[d", function() vim.diagnostic.jump({ count = -1 }) end, "Jump to previous diagnostic")
    map("]d", function() vim.diagnostic.jump({ count =  1 }) end, "Jump to next diagnostic"    )
    map("<leader>cd", vim.diagnostic.open_float, "Show diagnostic detail in float")
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
  clangd   = { cmd = { "clangd" },                            filetypes = { "c", "cpp", "objc", "objcpp" } },
  pyright  = { cmd = { "pyright-langserver", "--stdio" },     filetypes = { "python"                      } },
  bashls   = { cmd = { "bash-language-server", "start" },     filetypes = { "sh", "bash"                  } },
  texlab   = { cmd = { "texlab" },                            filetypes = { "tex", "bib"                  } },
  tinymist = {
    cmd       = { "tinymist" },
    filetypes = { "typst" },
    settings  = { exportPdf = "onSave" }, -- regenerate PDF on every save
  },
}

for name, config in pairs(servers) do
  config.capabilities = capabilities
  vim.lsp.config(name, config)
end

vim.lsp.enable(vim.tbl_keys(servers))

-- ── Diagnostic display ────────────────────────────────────────────────────────
vim.diagnostic.config({
  virtual_text     = { prefix = "●" }, -- inline diagnostic marker
  signs            = true,
  underline        = true,
  update_in_insert = false,            -- only update diagnostics on leaving insert mode
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

-- ── Clipboard ─────────────────────────────────────────────────────────────────
-- Explicit bridge between neovim's internal clipboard and the system clipboard.
-- Neovim's "+" register maps to wl-clipboard via the config above.
--
-- KEYBINDS:
--   <leader>y    (n/v) — yank selection to system clipboard
--   <leader>Y    (n)   — yank current line to system clipboard
--   <leader>p    (n/v) — paste from system clipboard after cursor
--   <leader>P    (n/v) — paste from system clipboard before cursor
map({ "n", "v" }, "<leader>y", '"+y',  { desc = "Yank selection to system clipboard"        })
map("n",          "<leader>Y", '"+yy', { desc = "Yank current line to system clipboard"     })
map({ "n", "v" }, "<leader>p", '"+p',  { desc = "Paste from system clipboard after cursor"  })
map({ "n", "v" }, "<leader>P", '"+P',  { desc = "Paste from system clipboard before cursor" })

-- ── Window navigation ─────────────────────────────────────────────────────────
-- Move between splits with Ctrl + hjkl (mirrors tmux-style navigation).
--
-- KEYBINDS:
--   <C-h/j/k/l>  — focus the split to the left / below / above / right
map("n", "<C-h>", "<C-w>h", { desc = "Focus split to the left"  })
map("n", "<C-j>", "<C-w>j", { desc = "Focus split below"        })
map("n", "<C-k>", "<C-w>k", { desc = "Focus split above"        })
map("n", "<C-l>", "<C-w>l", { desc = "Focus split to the right" })

-- ── Window resize ─────────────────────────────────────────────────────────────
-- Ctrl + arrow keys grow or shrink the current split by 2 units at a time.
--
-- KEYBINDS:
--   <C-Up/Down>    — increase / decrease window height by 2 rows
--   <C-Left/Right> — decrease / increase window width by 2 columns
map("n", "<C-Up>",    "<cmd>resize +2<cr>",          { desc = "Increase window height by 2 rows"   })
map("n", "<C-Down>",  "<cmd>resize -2<cr>",          { desc = "Decrease window height by 2 rows"   })
map("n", "<C-Left>",  "<cmd>vertical resize -2<cr>", { desc = "Decrease window width by 2 columns" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width by 2 columns" })

-- ── Terminal mode ─────────────────────────────────────────────────────────────
-- Navigate out of terminal buffers with the same keys as normal splits.
--
-- KEYBINDS:
--   <Esc><Esc>   — exit terminal mode (return to normal)
--   <C-h/j/k/l>  — same split navigation as normal mode (auto-exits terminal)
map("t", "<Esc><Esc>", "<C-\\><C-n>",       { desc = "Exit terminal mode"                 })
map("t", "<C-h>",      "<C-\\><C-n><C-w>h", { desc = "Terminal: focus split to the left"  })
map("t", "<C-j>",      "<C-\\><C-n><C-w>j", { desc = "Terminal: focus split below"        })
map("t", "<C-k>",      "<C-\\><C-n><C-w>k", { desc = "Terminal: focus split above"        })
map("t", "<C-l>",      "<C-\\><C-n><C-w>l", { desc = "Terminal: focus split to the right" })

-- ── Misc ──────────────────────────────────────────────────────────────────────
-- KEYBINDS:
--   <leader>qq   — quit all windows (prompts if unsaved changes exist)
--   <leader>tt   — open a 15-line terminal split at the bottom of the screen
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all windows" })

map("n", "<leader>tt", function()
  vim.cmd("botright 15split | terminal")
  vim.cmd("startinsert")
end, { desc = "Open terminal in bottom split" })
