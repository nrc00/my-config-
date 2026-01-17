-- [[ Autocommands ]]
-- This file defines event-based actions (autocommands).

-- Auto-Save Feature
-- Automatically saves all buffers when focus is lost or when leaving a buffer.
-- This prevents data loss and keeps files up-to-date.
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
  pattern = "*",
  command = "silent! wall",
  desc = "Auto-save all buffers on focus lost or buffer leave",
})
