-- [[ Main Entry Point ]]
-- This file is the first to be loaded when Neovim starts.
-- It orchestrates the loading of options, plugins, and keymaps.

-- Load general editor options (UI, search, performance settings).
require("config.options")

-- Initialize the plugin manager and load all plugins.
require("config.lazy")

-- Define global keymappings and utility shortcuts.
require("config.keymaps")

