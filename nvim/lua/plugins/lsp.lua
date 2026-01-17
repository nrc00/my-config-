-- [[ LSP Configuration ]]
-- This module sets up the Language Server Protocol (LSP) for Neovim.
-- It integrates Mason for server management and Blink.cmp for fast completion.

return {
  -- lazydev.nvim: Better Lua development settings for Neovim's internal API.
  {
    "folke/lazydev.nvim",
    ft = "lua", -- Only load for Lua files to save resources.
    opts = {
      library = {
        -- Load luv (libuv) library types for vim.uv usage.
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  -- nvim-lspconfig: The primary configuration hub for language servers.
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Mason: Portable package manager for language servers, linters, and formatters.
      "williamboman/mason.nvim",
      
      -- mason-lspconfig: Bridges the gap between Mason and lspconfig.
      "williamboman/mason-lspconfig.nvim",
      
      -- blink.cmp: High-performance completion engine.
      "saghen/blink.cmp",
      
      -- fidget.nvim: Extensible UI for LSP status notifications (e.g., "Indexing...").
      { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
      -- Initialize Mason.
      require("mason").setup()

      local lspconfig = require("lspconfig")
      
      -- Get optimized capabilities from blink.cmp to enable advanced completion features.
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Global diagnostic configuration (Neovim 0.10+ Best Practices).
      vim.diagnostic.config({
        underline = true,
        update_in_insert = false, -- Don't show diagnostics while typing.
        virtual_text = {
          spacing = 4,
          source = "if_many", -- Show source if multiple LSPs are running.
          prefix = "●", -- Subtle diagnostic marker.
        },
        severity_sort = true, -- Sort by severity for easier prioritization.
      })

      -- Function to be called when an LSP attaches to a buffer.
      -- This is where we define buffer-local keymaps for LSP features.
      local on_attach = function(_, bufnr)
        local nmap = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
        end
        
        -- Symbol renaming.
        nmap("<leader>rn", vim.lsp.buf.rename, "Rename")
        
        -- Context-aware code actions (e.g., fix imports, refactor).
        nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
        
        -- Jump to symbol definition.
        nmap("gd", vim.lsp.buf.definition, "Definition")
        
        -- Find references using fzf-lua.
        nmap("gr", require("fzf-lua").lsp_references, "References")
        
        -- Show hover documentation for the symbol under the cursor.
        nmap("K", vim.lsp.buf.hover, "Hover")
      end

      -- Configure Mason-LSPConfig with automatic server setup.
      require("mason-lspconfig").setup({
        -- Servers to ensure are installed on the system.
        ensure_installed = { "lua_ls", "rust_analyzer", "gopls", "tinymist" },
        
        -- Handlers define how each server is initialized.
        handlers = {
          function(server_name)
            local opts = {
              capabilities = capabilities,
              on_attach = on_attach,
            }

            if server_name == "lua_ls" then
              opts.settings = {
                Lua = {
                  -- Let lua_ls recognize the 'vim' global.
                  diagnostics = { globals = { "vim" } },
                },
              }
            end

            -- Specialized settings for Tinymist (Typst)
            if server_name == "tinymist" then
              opts.offset_encoding = "utf-8"
              opts.single_file_support = true
              opts.settings = {
                exportPdf = "onType",
                -- We disable the internal background preview to let typst-preview.nvim handle it
                -- with full scroll sync capabilities.
                -- preview = { ... } 
              }
            end

            -- Apply settings and initialize the server via lspconfig.
            lspconfig[server_name].setup(opts)
          end,
        },
      })
    end,
  },
}
