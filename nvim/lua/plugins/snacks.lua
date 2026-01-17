-- [[ Snacks.nvim Configuration ]]
-- Snacks is a collection of high-performance Neovim utilities.
-- It provides animations, big file support, dashboards, pickers, and more.

return {
  {
    "folke/snacks.nvim",
    priority = 1000, -- Load early to ensure animations and other utilities are ready.
    lazy = false,    -- Loaded on startup to provide global features.
    
    ---@type snacks.Config
    opts = {
      -- animate: Provides smooth animations for UI elements.
      animate = { enabled = true },
      
      -- bigfile: Automatically optimizes Neovim settings when opening very large files.
      bigfile = { enabled = true },
      
      -- dashboard: Highly customizable startup screen with ASCII art and session management.
      dashboard = {
        enabled = true,
        preset = {
          -- custom ASCII header (Fixed: Using preset.header for perfect alignment).
          header = [[
███╗   ██╗██╗ ██████╗  ██████╗ ███████╗██████╗ ██╗   ██╗██╗███╗   ███╗    
████╗  ██║██║██╔════╝ ██╔════╝ ██╔════╝██╔══██╗██║   ██║██║████╗ ████║    
██╔██╗ ██║██║██║  ███╗██║  ███╗█████╗  ██████╔╝██║   ██║██║██╔████╔██║    
██║╚██╗██║██║██║   ██║██║   ██║██╔══╝  ██╔══██╗╚██╗ ██╔╝██║██║╚██╔╝██║    
██║ ╚████║██║╚██████╔╝╚██████╔╝███████╗██║  ██║ ╚████╔╝ ██║██║ ╚═╝ ██║    
╚═╝  ╚═══╝╚═╝ ╚═════╝  ╚═════╝ ╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        },
        -- sections: Define the layout of the dashboard.
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 }, -- Quick access keys.
          { section = "startup" },                   -- Startup metrics (time it took to load).
        },
      },
      
      -- indent: Better indentation guides for code structure visibility.
      indent = { enabled = true },
      
      -- input: Modern UI for input prompts (replacing :vim.ui.input).
      input = { enabled = true },
      
      -- notifier: Sleek notification system (replacing default :echo).
      notifier = { enabled = true },
      
      -- picker: Blazingly fast fuzzy finder for files, git, and more.
      picker = { enabled = true },
      
      -- quickfile: Optimization that allows Neovim to open files instantly.
      quickfile = { enabled = true },
      
      -- scroll: Smooth scrolling experience with kinetic physics.
      scroll = { enabled = true },
      
      -- statuscolumn: Modern gutter with click support and diagnostic icons.
      statuscolumn = { enabled = true },
      
      -- words: Highlight and navigate through occurrences of the word under cursor.
      words = { enabled = true },
      
      -- zen: Distraction-free writing mode (centered text, hidden UI).
      zen = { enabled = true },
      
      -- terminal: Integrated terminal toggle with modern styling.
      terminal = { enabled = true },
      
      -- select: Modern UI for choice prompts (replacing :vim.ui.select).
      select = { enabled = true },
      
      -- image: High-performance image rendering in the terminal (WezTerm compatible).
      image = { enabled = true },
    },
    
    -- Global keymaps specifically for Snacks.nvim modules.
    keys = {
      { "<leader>z",  function() Snacks.zen() end, desc = "Zen Mode" },
      { "<leader>.",  function() Snacks.scratch() end, desc = "Scratch Buffer" },
      { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
      { "<c-/>",      function() Snacks.terminal() end, desc = "Terminal" },
      { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame" },
      { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse" },
    },
  },
}
