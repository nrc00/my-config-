-- [[ Typst Configuration ]]
-- Specialized settings for the Typst markup language.
-- Provides live preview and integrated tools for academic writing.

return {
  -- typst-preview.nvim: Live, high-performance preview for Typst files.
  {
    "chomosuke/typst-preview.nvim",
    ft = "typst", -- Only load when editing Typst files.
    version = "1.*", -- Use the stable v1 release.
    build = function()
      -- Automatically update the underlying preview binary on installation/update.
      require("typst-preview").update()
    end,
    opts = {
      -- Automatically open the preview when entering a Typst buffer.
      open_auto = true,
      -- Ensure scroll sync is enabled (it is by default, but being explicit helps).
      follow_cursor = true,
    },
    -- Keymappings for controlling the preview.
    keys = {
      -- Start the live preview in your default browser.
      { "<leader>tp", "<cmd>TypstPreview<cr>", desc = "Typst Preview" },
      -- Stop the live preview server.
      { "<leader>ts", "<cmd>TypstPreviewStop<cr>", desc = "Typst Stop Preview" },
      -- Sync cursor position
      { "<leader>tc", "<cmd>TypstPreviewSyncCursor<cr>", desc = "Typst Sync Cursor" },
    },
  },
}
