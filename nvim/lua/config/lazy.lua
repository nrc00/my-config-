-- [[ Lazy.nvim Bootstrap ]]
-- This section ensures that lazy.nvim is installed on the system.
-- If not found, it clones the repository from GitHub.

-- Define the path where lazy.nvim will be installed.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check if the lazy.nvim directory exists.
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- URL for the lazy.nvim GitHub repository.
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  
  -- Use git to clone the repository to the lazypath.
  -- --filter=blob:none makes the clone faster by only downloading history.
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  
  -- Check for errors during the git clone process.
  if vim.v.shell_error ~= 0 then
    -- Echo an error message to the Neovim UI.
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    
    -- Wait for user input before exiting Neovim.
    vim.fn.getchar()
    os.exit(1)
  end
end

-- Prepend the lazypath to the runtime path (rtp).
-- This allows Neovim to find and load the lazy.nvim plugin.
vim.opt.rtp:prepend(lazypath)

-- Load autocommands
require("config.autocmds")

-- [[ Lazy.nvim Setup ]]
-- Configure the plugin manager with custom settings.

require("lazy").setup({
  -- The spec table defines which plugins to load.
  spec = {
    -- Automatically import all files in the 'plugins' directory.
    -- This keeps the configuration modular.
    { import = "plugins" },
  },
  
  -- Default settings for plugins.
  defaults = {
    -- By default, plugins are NOT lazy-loaded. 
    -- We prefer explicit lazy-loading in individual plugin files for better control.
    lazy = false,
    
    -- Use the latest git commit for plugins instead of stable releases.
    -- This ensures we have the latest features and bug fixes.
    version = false, 
  },
  
  -- Automatically check for plugin updates.
  checker = { enabled = true },
  
  -- Performance optimizations for the runtime path.
  performance = {
    rtp = {
      -- Disable built-in Vim plugins that are often unnecessary or replaced.
      -- This reduces startup time and clutter.
      disabled_plugins = {
        "gzip",          -- Binary file compression support
        "matchit",       -- Extended % matching
        "matchparen",    -- Highlight matching parentheses
        "netrwPlugin",   -- Built-in file explorer (often replaced by NvimTree)
        "tarPlugin",     -- Tar archive support
        "tohtml",        -- Convert buffer to HTML
        "tutor",         -- Neovim tutor
        "zipPlugin",     -- Zip archive support
      },
    },
  },
})
