-- [[ Global Keybindings ]]
-- This file defines global keybindings accessible in all file types.
-- We use vim.keymap.set for a modern, consistent way to define maps.

-- Local alias for vim.keymap.set to keep the file concise and readable.
local map = vim.keymap.set

-- [[ General Utilities ]]

-- Clear search highlights when pressing <Esc> in Normal Mode.
-- This is much more convenient than typing :nohl every time.
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Quick save with <leader>w.
-- Saves the current buffer to disk.
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })

-- Safe quit with <leader>q.
-- Uses :confirm to ask for saving if there are unsaved changes.
map("n", "<leader>q", "<cmd>confirm q<cr>", { desc = "Quit" })

-- [[ Visual Mode Enhancements ]]

-- Improve indentation in Visual Mode.
-- Re-selects the visual block after indenting, allowing for multiple indents in a row.
map("v", "<", "<vgv")
map("v", ">", ">gv")

-- [[ Buffer Management ]]

-- Quickly switch between open buffers using Shift+h and Shift+l.
-- Shift+h (H): Move to the previous buffer in the list.
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })

-- Shift+l (L): Move to the next buffer in the list.
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })

-- [[ Diagnostics Navigation ]]

-- Navigate through LSP diagnostic messages (Errors, Warnings, etc.).
-- [d: Jump to the previous diagnostic message in the current buffer.
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })

-- ]d: Jump to the next diagnostic message in the current buffer.
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })

-- Show diagnostic details in a floating window with <leader>e.
-- Useful for reading long error messages without moving the cursor.
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })

-- Open the diagnostic list in a loclist window with <leader>gl.
-- Allows you to see all diagnostics in the current buffer at once.
map('n', '<leader>gl', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
