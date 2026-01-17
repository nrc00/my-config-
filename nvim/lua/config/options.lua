-- [[ General Editor Options ]]
-- These settings control the basic behavior and appearance of Neovim.

-- vim.g.mapleader: Define the leader key for custom mappings.
-- Setting it to " " (space) is a modern standard for easy access with the thumb.
vim.g.mapleader = " "

-- vim.g.maplocalleader: Define the local leader key, often used for file-type specific plugins.
-- We keep it as " " for consistency across all mappings.
vim.g.maplocalleader = " "

-- Local reference to vim.opt for shorter and more readable configuration.
local opt = vim.opt

-- [[ UI & Appearance ]]

-- opt.number: Enable absolute line numbers in the gutter.
-- Essential for knowing exactly which line you are on.
opt.number = true

-- opt.relativenumber: Show relative line numbers from the current line.
-- This makes jumping to other lines with {count}j/k much faster.
opt.relativenumber = true

-- opt.background: Set the background color brightness.
-- We set it to "light" to ensure the Kanagawa Lotus theme displays its bright yellowish variant.
opt.background = "light"

-- opt.showmode: Disable the default mode message (e.g., -- INSERT --) at the bottom.
-- We use statusline plugins like lualine or snacks.nvim which already display the mode.
opt.showmode = false

-- opt.clipboard: Synchronize Neovim's clipboard with the system clipboard.
-- "unnamedplus" ensures that yanks and deletes go to the system's global clipboard.
opt.clipboard = "unnamedplus"

-- Specialized Wayland clipboard configuration for Linux systems.
-- This ensures smooth copy/paste when running Neovim in Wayland environments.
if vim.fn.executable("wl-copy") == 1 then
  vim.g.clipboard = {
    name = "wl-clipboard",
    copy = { ["+"] = "wl-copy --type text/plain", ["*"] = "wl-copy --type text/plain --primary" },
    paste = { ["+"] = "wl-paste --type text/plain --no-selection", ["*"] = "wl-paste --type text/plain --primary --no-selection" },
    cache_enabled = 1,
  }
end

-- opt.breakindent: Keep indentation when lines wrap.
-- Improves readability for long lines of code or text.
opt.breakindent = true

-- opt.undofile: Enable persistent undo across sessions.
-- Neovim saves undo history in a file, allowing you to undo changes after reopening.
opt.undofile = true

-- [[ Search Behavior ]]

-- opt.ignorecase: Ignore case in search patterns.
-- Makes searching more flexible (e.g., /foo matches /Foo).
opt.ignorecase = true

-- opt.smartcase: Override ignorecase if the search pattern contains uppercase characters.
-- If you type /Foo, it will only match case-sensitively.
opt.smartcase = true

-- [[ Feedback & Performance ]]

-- opt.signcolumn: Always show the sign column (where diagnostics and git signs appear).
-- Prevents the text from shifting layout when signs are added or removed.
opt.signcolumn = "yes"

-- opt.updatetime: Time (in ms) to wait before triggering certain events (like CursorHold).
-- Smaller values (200ms) make UI responsive and trigger diagnostic popups faster.
opt.updatetime = 200

-- opt.timeoutlen: Time (in ms) to wait for a mapped sequence to complete.
-- 300ms is a good balance between speed and allowing time for multi-key mappings.
opt.timeoutlen = 300

-- [[ Splitting & Layout ]]

-- opt.splitright: Vertical splits will open to the right of the current window.
-- More intuitive for most modern development workflows.
opt.splitright = true

-- opt.splitbelow: Horizontal splits will open below the current window.
-- Standard behavior for terminals and quickfix windows.
opt.splitbelow = true

-- [[ Whitespace Visibility ]]

-- opt.list: Show invisible characters like tabs and trailing spaces.
-- Essential for maintaining clean code according to style guides.
opt.list = true

-- opt.listchars: Define how to display invisible characters.
-- Use subtle symbols to avoid visual distraction.
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- [[ Command Line Logic ]]

-- opt.inccommand: Preview substitutions (like :s/foo/bar) in a split window.
-- This allows you to see the effect of your search/replace as you type it.
opt.inccommand = "split"

-- [[ Scrolling & Navigation ]]

-- opt.cursorline: Highlight the current line in the editor.
-- Helps you quickly locate the cursor position.
opt.cursorline = true

-- opt.scrolloff: Minimum number of lines to keep above/below the cursor.
-- Setting it to 10 ensures you always see the surrounding context of your code.
opt.scrolloff = 10

-- opt.termguicolors: Enable 24-bit RGB colors in the TUI.
-- Required for modern themes like Kanagawa or Tokyo Night to look their best.
opt.termguicolors = true

-- opt.smoothscroll: Enable native smooth scrolling (introduced in Neovim 0.10).
-- Makes scrolling with the mouse or half-page jumps feel fluid.
opt.smoothscroll = true

-- opt.laststatus: Global statusline (value 3).
-- Instead of a statusline per window, show one single statusline at the very bottom.
opt.laststatus = 3

-- [[ Performance & State ]]

-- opt.virtualedit: Allow the cursor to move past the end of the line in block mode.
-- Useful for complex visual block selections.
opt.virtualedit = "block"

-- opt.sessionoptions: Control what gets saved in a session file.
-- Optimized to restore exactly what you were working on without unnecessary baggage.
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

-- opt.shada: Optimized ShaDa (Shared Data) configuration.
-- Limits the amount of history saved to keep startup times fast and disk usage low.
opt.shada = "!,'100,<50,s10,h"
