-- [[ Utility & UI Enhancement Plugins ]]
-- This module contains miscellaneous tools that improve the overall editor experience.

return {
  -- tiny-inline-diagnostic.nvim: Provides premium, high-quality inline diagnostics.
  -- Displays error messages right next to the code with beautiful styling.
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach", -- Load only when an LSP is active.
    priority = 1000,     -- High priority to ensure diagnostics are visible immediately.
    opts = {
      preset = "modern", -- Use the sleek modern UI preset.
      options = {
        show_source = true, -- Include the source of the diagnostic (e.g., lua_ls).
      }
    },
    config = function(_, opts)
      -- Setup the tiny-inline-diagnostic engine.
      require('tiny-inline-diagnostic').setup(opts)
      
      -- Disable Neovim's default virtual text to avoid overlap with this plugin's UI.
      vim.diagnostic.config({ virtual_text = false })
    end
  },

  -- which-key.nvim: Interactive cheat-sheet for your keybindings.
  -- Helps you discover and remember complex multi-key mappings.
  {
    "folke/which-key.nvim",
    event = "VeryLazy", -- Load late to avoid slowing down startup.
    opts = {
      preset = "modern", -- Consistent aesthetic with other plugins.
    },
  },

  -- lualine.nvim: A fast and easy-to-configure statusline.
  -- Displays important information like mode, branch, and file type at the bottom.
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        -- theme = "auto",       -- Automatically detect defaults
        component_separators = "", -- Flat, modern look with no separators.
        section_separators = "",   -- Seamless transitions between sections.
      },
    },
  },

  -- gitsigns.nvim: Git integration in the gutter.
  -- Shows icons for added, modified, and deleted lines.
  {
    "lewis6991/gitsigns.nvim",
    opts = {}, -- Default options provides excellent out-of-the-box experience.
  },
}
