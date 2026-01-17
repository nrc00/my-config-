-- [[ Navigation & File Management ]]
-- This file configures plugins that help you move through files and directories.

return {
  -- oil.nvim: Edit your file system like a normal Neovim buffer.
  -- Allows for batch renaming, moving, and deleting files using Neovim commands.
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- File icons for better UI.
    opts = {
      -- Show file icons in the oil buffer.
      columns = { "icon" },
      -- Always show hidden files (e.g., .git, .env).
      view_options = { show_hidden = true },
    },
    keys = { 
      -- Use "-" to open the parent directory in the current window.
      { "-", "<CMD>Oil<CR>", desc = "Open Parent Directory" } 
    },
  },

  -- mini.files: A minimal, sleek file explorer for Neovim.
  -- Provides a column-based navigation experience.
  {
    "echasnovski/mini.files",
    opts = {}, -- Default options are well-balanced for most users.
    keys = {
      -- Toggle the mini.files explorer.
      { "<leader>fm", function() require("mini.files").open() end, desc = "Mini Files" },
    },
  },

  -- flash.nvim: Blazingly fast motion plugin.
  -- Allows you to jump to any character on the screen with just a few keystrokes.
  {
    "folke/flash.nvim",
    opts = {}, -- Standard configuration for seamless jumping.
    keys = {
      -- Global search and jump mapping ("s").
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash Jump" },
    },
  },
}
