-- [[ UI & Aesthetic Configuration ]]
-- This file configures the visual elements of Neovim.

return {
  -- nvim-treesitter: High-performance syntax highlighting and code analysis.
  -- It builds a syntax tree of your code for elite-level coloring.
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- Automatically update parsers when the plugin is updated.
    config = function()
      -- Setup TreeSitter with a comprehensive set of language parsers.
      require("nvim-treesitter.configs").setup({
        -- Languages to ensure are installed for elite highlighting.
        ensure_installed = { 
          "lua", "vim", "vimdoc", "query", "bash", "markdown", "markdown_inline",
          "rust", "go", "json", "yaml", "html", "css", "javascript", "typescript",
          "tsx", "typst"
        },
        
        -- Enable high-performance syntax highlighting.
        highlight = { enabled = true },
        
        -- Enable intelligent indentation based on the syntax tree.
        indent = { enabled = true },
      })
    end,
  },
  
  -- Force Neovim to use the terminal's own palette (ANSI colors)
  {
    "folke/lazy.nvim",
    priority = 1000,
    opts = function()
      -- Disable True Color to use terminal ANSI colors directly
      vim.opt.termguicolors = false
      
      -- Force 'dark' background (light text) to ensure readability on transparent/dark terminals
      vim.opt.background = "dark"
      
      vim.cmd.colorscheme("default") 
      
      -- Transparency: Clear backgrounds to allow terminal blur to show through
      local transparent_groups = {
        "Normal", "NormalNC", "Comment", "Constant", "Special", "Identifier",
        "Statement", "PreProc", "Type", "Underlined", "Todo", "String", "Function",
        "Conditional", "Repeat", "Operator", "Structure", "LineNr", "NonText",
        "SignColumn", "CursorLine", "CursorLineNr", "StatusLine", "StatusLineNC",
        "EndOfBuffer",
      }
      
      for _, group in ipairs(transparent_groups) do
        vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
      end
    end,
  }
}
