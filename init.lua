-- ============================================================
-- Highlight Yank
-- ============================================================
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  desc = "Briefly highlight yanked text",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

-- ============================================================
-- Autosave
-- ============================================================
-- Saves when:
--   - leaving a buffer (BufLeave)
--   - switching focus away from nvim (FocusLost)
--   - going idle in normal mode (CursorHold)
--
-- Skips:
--   - unnamed buffers (no file on disk yet)
--   - read-only buffers
--   - non-normal buftypes (terminal, quickfix, nofile, prompt)
--   - unmodified buffers (no-op anyway, but avoids unnecessary disk writes)

local autosave_group = vim.api.nvim_create_augroup("autosave", { clear = true })

local function should_save(buf)
  if not vim.api.nvim_buf_is_valid(buf) then return false end
  if not vim.bo[buf].modified then return false end
  if vim.bo[buf].readonly then return false end
  if vim.fn.bufname(buf) == "" then return false end

  local non_file_buftypes = { terminal = true, quickfix = true, nofile = true, prompt = true }
  if non_file_buftypes[vim.bo[buf].buftype] then return false end

  return true
end

local function save(buf)
  if should_save(buf) then
    vim.api.nvim_buf_call(buf, function()
      vim.cmd("silent! write")
    end)
  end
end

-- Save on idle (normal mode only)
vim.api.nvim_create_autocmd("CursorHold", {
  group = autosave_group,
  desc = "Autosave after updatetime ms of inactivity",
  callback = function()
    save(vim.api.nvim_get_current_buf())
  end,
})
-- Save on every entry to normal mode
vim.api.nvim_create_autocmd("ModeChanged", {
  group = autosave_group,
  pattern = "*:n",
  desc = "Autosave when entering normal mode",
  callback = function()
    save(vim.api.nvim_get_current_buf())
  end,
})
-- Save when leaving a buffer or losing focus
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  group = autosave_group,
  desc = "Autosave on buffer leave or focus lost",
  callback = function(args)
    local buf = args.buf or vim.api.nvim_get_current_buf()
    -- Defer for the same reason as conform: lets plugins finish
    -- initializing before we attempt a write (CopilotChat, grug-far, etc.)
    vim.defer_fn(function()
      save(buf)
    end, 100)
  end,
})
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
opt.tabstop                   = 2
opt.shiftwidth                = 2
opt.expandtab                 = true
opt.number                    = true
opt.relativenumber            = true
opt.ignorecase                = true
opt.smartcase                 = true
opt.undofile                  = true
opt.scrolloff                 = 20
opt.sidescrolloff             = 36
opt.wrap                      = false
opt.clipboard                 = ""   -- keep internal clipboard isolated
opt.autoread                  = true -- required by opencode.nvim

-- =============================================================================
-- WAYLAND CLIPBOARD
-- =============================================================================
vim.g.clipboard               = {
  name = "wl-clipboard",
  copy = {
    ["+"] = { "wl-copy", "--type", "text/plain" },
    ["*"] = { "wl-copy", "--primary" },
  },
  paste = {
    ["+"] = { "wl-paste", "--no-newline" },
    ["*"] = { "wl-paste", "--primary", "--no-newline" },
  },
  cache_enabled = true,
}

-- =============================================================================
-- BOOTSTRAP LAZY.NVIM
-- =============================================================================
local lazypath                = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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
    -- -------------------------------------------------------------------------
    -- 1. COLORSCHEME
    -- -------------------------------------------------------------------------
    {
      "rose-pine/neovim",
      name = "rose-pine",
      priority = 1000,
      lazy = false,
      config = function()
        vim.cmd("colorscheme rose-pine")
      end,
    },

    -- -------------------------------------------------------------------------
    -- 2. TREESITTER
    -- -------------------------------------------------------------------------
    {
      "nvim-treesitter/nvim-treesitter",
      lazy = false,
      build = ":TSUpdate",
      opts = {
        ensure_installed = {
          "c", "lua", "vim", "vimdoc", "query",
          "bash", "json", "yaml",
          "latex", "typst", "regex",
        },
        highlight        = { enable = true },
        indent           = { enable = true },
      },
      config = function(_, opts)
        require("nvim-treesitter").setup(opts)
        vim.treesitter.language.register("bash", "sh")
      end,
    },

    -- -------------------------------------------------------------------------
    -- 3. TREESITTER TEXTOBJECTS
    -- -------------------------------------------------------------------------
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      branch = "main",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      opts = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
          },
        },
        move = {
          enable              = true,
          set_jumps           = true,
          goto_next_start     = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
          goto_next_end       = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
          goto_previous_end   = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
        },
      },
      config = function(_, opts)
        require("nvim-treesitter-textobjects").setup(opts)
      end,
    },

    -- -------------------------------------------------------------------------
    -- 4. MINI.NVIM
    -- -------------------------------------------------------------------------
    {
      "echasnovski/mini.nvim",
      version = "*",
      config = function()
        require("mini.pairs").setup()

        require("mini.surround").setup({
          mappings = {
            add            = "gza",
            delete         = "gzd",
            find           = "gzf",
            find_left      = "gzF",
            highlight      = "gzh",
            replace        = "gzr",
            update_n_lines = "gzn",
          },
        })

        require("mini.icons").setup()
        MiniIcons.mock_nvim_web_devicons() -- add this line

        require("mini.comment").setup({
          options = {
            custom_commentstring = function()
              return require("ts_context_commentstring.internal").calculate_commentstring()
                  or vim.bo.commentstring
            end,
          },
        })
      end,
    },

    -- -------------------------------------------------------------------------
    -- 4b. TS-CONTEXT-COMMENTSTRING
    -- -------------------------------------------------------------------------
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      lazy = true,
      opts = { enable_autocmd = false },
    },

    -- -------------------------------------------------------------------------
    -- 5. SNACKS.NVIM
    -- -------------------------------------------------------------------------
    {
      "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      opts = {
        bigfile      = { enabled = true },
        explorer     = { enabled = true, hidden = true },
        indent       = { enabled = true },
        input        = { enabled = true },
        notifier     = { enabled = true },
        quickfile    = { enabled = true },
        scope        = { enabled = true },
        scroll       = { enabled = true },
        statuscolumn = { enabled = true },
        words        = { enabled = true },
        dashboard    = {
          enabled = false,
          preset = {
            keys = {
              { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.picker.files()" },
              { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
              { icon = " ", key = "/", desc = "Find Text", action = ":lua Snacks.picker.grep()" },
              { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.picker.recent()" },
              { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })" },
              { icon = " ", key = "s", desc = "Restore Session", section = "session" },
              { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy" },
              { icon = " ", key = "q", desc = "Quit", action = ":qa" },
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
              keys = {
                ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
              },
            },
          },
        },
      },
      keys = {
        -- Files
        { "<leader>ff", function() Snacks.picker.files() end,                desc = "Find files" },
        { "<leader>fg", function() Snacks.picker.grep() end,                 desc = "Live grep" },
        { "<leader>fb", function() Snacks.picker.buffers() end,              desc = "Buffers" },
        { "<leader>fr", function() Snacks.picker.recent() end,               desc = "Recent files" },
        { "<leader>fh", function() Snacks.picker.help() end,                 desc = "Help tags" },
        -- Explorer
        { "<leader>e",  function() Snacks.explorer({ hidden = true }) end,   desc = "File explorer" },
        -- Diagnostics
        { "<leader>xd", function() Snacks.picker.diagnostics() end,          desc = "Diagnostics" },
        { "<leader>xb", function() Snacks.picker.diagnostics_buffer() end,   desc = "Buffer diagnostics" },
        -- LSP
        { "gd",         function() Snacks.picker.lsp_definitions() end,      desc = "Go to definition" },
        { "gr",         function() Snacks.picker.lsp_references() end,       desc = "References" },
        { "gI",         function() Snacks.picker.lsp_implementations() end,  desc = "Implementations" },
        { "gt",         function() Snacks.picker.lsp_type_definitions() end, desc = "Type definition" },
        { "<leader>ls", function() Snacks.picker.lsp_symbols() end,          desc = "LSP symbols" },
        -- Notifications
        { "<leader>nh", function() Snacks.notifier.show_history() end,       desc = "Notification history" },
        -- Git
        { "<leader>gl", function() Snacks.picker.git_log() end,              desc = "Git log" },
        { "<leader>gs", function() Snacks.picker.git_status() end,           desc = "Git status" },
      },
    },

    -- -------------------------------------------------------------------------
    -- 6. OPENCODE.NVIM
    -- -------------------------------------------------------------------------
    {
      "nickjvandyke/opencode.nvim",
      version = "*",
      dependencies = { "folke/snacks.nvim" },
      config = function()
        vim.g.opencode_opts = {}

        local function map(keys, func, desc, mode)
          mode = mode or { "n", "x" }
          vim.keymap.set(mode, keys, func, { desc = "Opencode: " .. desc })
        end

        map("<leader>oa", function() require("opencode").ask("@this: ", { submit = true }) end, "Ask")
        map("<leader>ox", function() require("opencode").select() end, "Select action")
        map("<leader>ot", function() require("opencode").toggle() end, "Toggle", { "n", "t" })
        map("<leader>os", function() return require("opencode").operator("@this ") end, "Send range", { expr = true })
        map("<leader>ol", function() return require("opencode").operator("@this ") .. "_" end, "Send line",
          { "n", expr = true })
        map("<leader>ou", function() require("opencode").command("session.half.page.up") end, "Scroll up")
        map("<leader>od", function() require("opencode").command("session.half.page.down") end, "Scroll down")
      end,
    },

    -- -------------------------------------------------------------------------
    -- 7. WINDSURF.NVIM (Codeium)
    -- -------------------------------------------------------------------------
    {
      "Exafunction/windsurf.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        { "hrsh7th/nvim-cmp", config = false },
      },
      config = function()
        require("codeium").setup({
          virtual_text = {
            enabled = true,
            manual = false,
            key_bindings = {
              accept      = "<M-l>", -- Alt+l to accept full suggestion
              accept_word = "<M-w>", -- Alt+w to accept one word at a time
              next        = "<M-]>",
              prev        = "<M-[>",
              dismiss     = "<M-e>",
            },
          },
        })
        -- Toggle Codeium ghost text on/off
        vim.keymap.set("n", "<leader>ai", function()
          local status = vim.fn["codeium#Enabled"]()
          if status == 1 then
            vim.cmd("CodeiumDisable")
            vim.notify("Codeium disabled", vim.log.levels.INFO)
          else
            vim.cmd("CodeiumEnable")
            vim.notify("Codeium enabled", vim.log.levels.INFO)
          end
        end, { desc = "Toggle Codeium" })
      end,
    },
    -- -------------------------------------------------------------------------
    -- 8. LUALINE
    -- -------------------------------------------------------------------------
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "echasnovski/mini.nvim" },
      opts = {
        options = {
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

    -- -------------------------------------------------------------------------
    -- 9. BLINK.CMP
    -- -------------------------------------------------------------------------
    {
      "saghen/blink.cmp",
      dependencies = { "rafamadriz/friendly-snippets" },
      version = "1.*",
      opts = {
        keymap     = { preset = "default" },
        appearance = { nerd_font_variant = "mono" },
        completion = {
          documentation = { auto_show = true, auto_show_delay_ms = 300 },
        },
        sources    = {
          default = { "lsp", "path", "snippets", "buffer", },
          providers = {
            codeium = {
              name         = "codeium",
              module       = "codeium.blink",
              score_offset = 100,
            },
          },
        },
        fuzzy      = { implementation = "prefer_rust_with_warning" },
      },
      opts_extend = { "sources.default" },
    },

    -- -------------------------------------------------------------------------
    -- 10. NEOMINIMAP
    -- -------------------------------------------------------------------------
    {
      "Isrothy/neominimap.nvim",
      version = "v3.x.x",
      lazy = false,
      init = function()
        vim.g.neominimap = { auto_enable = true }
      end,
      keys = {
        { "<leader>mt", "<cmd>Neominimap Toggle<cr>",  desc = "Toggle minimap" },
        { "<leader>mf", "<cmd>Neominimap Focus<cr>",   desc = "Focus minimap" },
        { "<leader>mu", "<cmd>Neominimap Unfocus<cr>", desc = "Unfocus minimap" },
        { "<leader>mr", "<cmd>Neominimap Refresh<cr>", desc = "Refresh minimap" },
      },
    },

    -- -------------------------------------------------------------------------
    -- 11. CONFORM.NVIM
    -- -------------------------------------------------------------------------
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
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
      },
      keys = {
        {
          "<leader>cf",
          function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
          desc = "Format buffer",
        },
      },
    },

    -- -------------------------------------------------------------------------
    -- 12. BARBAR.NVIM
    -- -------------------------------------------------------------------------
    {
      "romgrk/barbar.nvim",
      lazy = false,
      dependencies = { "echasnovski/mini.nvim", "lewis6991/gitsigns.nvim" },
      version = "^1.0.0",
      init = function()
        vim.g.barbar_auto_setup = false
      end,
      opts = {},
      keys = {
        { "<Tab>",      "<cmd>BufferNext<cr>",               desc = "Next buffer" },
        { "<S-Tab>",    "<cmd>BufferPrevious<cr>",           desc = "Previous buffer" },
        { "<leader>bd", "<cmd>BufferClose<cr>",              desc = "Close buffer" },
        { "<leader>bp", "<cmd>BufferPin<cr>",                desc = "Pin/unpin buffer" },
        { "<leader>bo", "<cmd>BufferCloseAllButCurrent<cr>", desc = "Close other buffers" },
        { "<leader>bD", "<cmd>BufferCloseAllButPinned<cr>",  desc = "Close unpinned buffers" },
        { "<leader>bl", "<cmd>BufferMoveNext<cr>",           desc = "Move buffer right" },
        { "<leader>bh", "<cmd>BufferMovePrevious<cr>",       desc = "Move buffer left" },
        { "<leader>1",  "<cmd>BufferGoto 1<cr>",             desc = "Buffer 1" },
        { "<leader>2",  "<cmd>BufferGoto 2<cr>",             desc = "Buffer 2" },
        { "<leader>3",  "<cmd>BufferGoto 3<cr>",             desc = "Buffer 3" },
        { "<leader>4",  "<cmd>BufferGoto 4<cr>",             desc = "Buffer 4" },
        { "<leader>5",  "<cmd>BufferGoto 5<cr>",             desc = "Buffer 5" },
      },
    },

    -- -------------------------------------------------------------------------
    -- 13. FLASH.NVIM
    -- -------------------------------------------------------------------------
    {
      "folke/flash.nvim",
      event = "VeryLazy",
      opts = {},
      keys = {
        { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash jump" },
        { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash treesitter" },
        { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Flash remote" },
        { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Flash treesitter search" },
        { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle flash in search" },
      },
    },

    -- -------------------------------------------------------------------------
    -- 14. WHICH-KEY
    -- -------------------------------------------------------------------------
    { "folke/which-key.nvim", opts = {} },

    -- -------------------------------------------------------------------------
    -- 15. GITSIGNS
    -- -------------------------------------------------------------------------
    {
      "lewis6991/gitsigns.nvim",
      event = { "BufReadPre", "BufNewFile" },
      opts = {
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

          -- Hunk navigation
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
          end, "Prev hunk")

          -- Staging
          map({ "n", "v" }, "<leader>hs", gs.stage_hunk, "Stage hunk")
          map({ "n", "v" }, "<leader>hr", gs.reset_hunk, "Reset hunk")
          map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
          map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")
          map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")
          map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")

          -- Blame
          map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
          map("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle line blame")

          -- Diff
          map("n", "<leader>hd", gs.diffthis, "Diff this")
          map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff this ~")

          -- Text object
          map({ "o", "x" }, "ih", ":<C-u>Gitsigns select_hunk<cr>", "Select hunk")
        end,
      },
    },
  },

  install = { colorscheme = { "rose-pine", "habamax" } },
  checker = { enabled = true },
})

-- =============================================================================
-- LSP CONFIGURATION (Native Neovim 0.11)
-- =============================================================================
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
  callback = function(ev)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
    end

    map("K", vim.lsp.buf.hover, "Hover docs")
    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
    map("<leader>ci", vim.lsp.buf.incoming_calls, "Incoming calls")
    map("<leader>co", vim.lsp.buf.outgoing_calls, "Outgoing calls")
    map("[d", vim.diagnostic.goto_prev, "Prev diagnostic")
    map("]d", vim.diagnostic.goto_next, "Next diagnostic")
    map("<leader>cd", vim.diagnostic.open_float, "Show diagnostic")
  end,
})

local capabilities = require("blink.cmp").get_lsp_capabilities()

-- Server configurations
local servers = {
  lua_ls = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    settings = {
      Lua = {
        runtime     = { version = "LuaJIT" },
        workspace   = { checkThirdParty = false, library = vim.api.nvim_get_runtime_file("", true) },
        diagnostics = { globals = { "vim" } },
        telemetry   = { enable = false },
      },
    },
  },
  clangd = {
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
  },
  pyright = {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
  },
  bashls = {
    cmd = { "bash-language-server", "start" },
    filetypes = { "sh", "bash" },
  },
  texlab = {
    cmd = { "texlab" },
    filetypes = { "tex", "bib" },
  },
  tinymist = {
    cmd = { "tinymist" },
    filetypes = { "typst" },
    settings = { exportPdf = "onType" },
  },
}

for name, config in pairs(servers) do
  config.capabilities = capabilities
  vim.lsp.config(name, config)
end

vim.lsp.enable(vim.tbl_keys(servers))

-- Diagnostic UI
vim.diagnostic.config({
  virtual_text     = { prefix = "●" },
  signs            = true,
  underline        = true,
  update_in_insert = false,
  severity_sort    = true,
  float            = { border = "rounded", source = "always" },
})

-- =============================================================================
-- KEYMAPS
-- =============================================================================
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Clipboard
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map("n", "<leader>Y", '"+yy', { desc = "Yank line to system clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
map({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste from system clipboard (before)" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- Window resize
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Terminal
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Terminal: window left" })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Terminal: window down" })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Terminal: window up" })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Terminal: window right" })

map("n", "<leader>tt", function()
  vim.cmd("botright 15split | terminal")
  vim.cmd("startinsert")
end, { desc = "Open terminal (bottom split)" })
