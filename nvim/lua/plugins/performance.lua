-- [[ Performance & Search Configuration ]]
-- This module focuses on speed and efficiency for everyday development tasks.

return {
  -- blink.cmp: A blazingly fast completion engine written in Rust.
  -- It replaces nvim-cmp for 2025 performance standards.
  {
    'saghen/blink.cmp',
    version = '*', -- Use the latest version for performance improvements.
    opts = {
      -- Default keymap preset for an intuitive completion experience.
      keymap = { preset = 'default' },
      
      -- Aesthetic settings for the completion menu.
      appearance = {
        -- Enable compatibility with nvim-cmp fonts/icons if needed.
        use_nvim_cmp_as_default = true,
        -- Use Nerd Font Mono variant for consistent icon alignment.
        nerd_font_variant = 'mono'
      },
      
      -- Sources define where suggestions come from.
      sources = {
        -- LSP for code, Path for files, Snippets for templates, Buffer for text.
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      
      -- Completion behavior settings.
      completion = {
        -- Automatically select the first item and insert it for maximum speed.
        list = { selection = { preselect = true, auto_insert = true } },
        -- Single-line border for a sleek, modern look.
        menu = { border = 'single' },
        -- Show documentation on hover automatically.
        documentation = { auto_show = true, window = { border = 'single' } },
      }
    },
  },

  -- fzf-lua: A high-performance fuzzy finder powered by fzf.
  -- Optimized for speed and responsiveness in large projects.
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Required for file-type icons.
    keys = {
      -- Keymaps for finding files, grepping text, and switching buffers.
      { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Grep" },
      { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
    },
    opts = {
      -- Use the native fzf binary for maximum search performance.
      "fzf-native",
      -- Customize the appearance of the picker window.
      winopts = {
        height = 0.85,
        width = 0.80,
        preview = {
          -- Vertical layout with the preview at the bottom for better visibility.
          layout = 'vertical',
          vertical = 'down:45%',
        },
      },
    }
  },
}
