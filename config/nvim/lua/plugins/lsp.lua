return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local nvim_lsp = require('lspconfig')
      local util = require 'lspconfig.util'

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      vim.diagnostic.config({
        virtual_text = false,
      })

      nvim_lsp.ts_ls.setup {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          -- Enable completion triggered by <c-x><c-o>
          vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        end,
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            }
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            }
          }
        }
      }

      -- Ruby LSP servers
      -- Sorbet for typed Ruby
      nvim_lsp.sorbet.setup {
        cmd = { 'srb', 'tc', '--lsp' },
        capabilities = capabilities,
        filetypes = { 'ruby' },
        root_dir = util.root_pattern('sorbet'),
      }

      -- Ruby LSP for general Ruby completion (Shopify's ruby-lsp)
      -- nvim_lsp.ruby_lsp.setup {
      --   capabilities = capabilities,
      --   filetypes = { 'ruby' },
      --   cmd = { 'bundle', 'exec', 'ruby-lsp' },
      --   on_new_config = function(config, root_dir)
      --     -- Check if ruby-lsp is available via bundle
      --     local handle = io.popen('cd ' .. root_dir .. ' && bundle list 2>/dev/null | grep -q ruby-lsp && echo "found"')
      --     local result = handle:read("*a")
      --     handle:close()

      --     if result:match("found") then
      --       -- Use bundled ruby-lsp
      --       config.cmd = { 'bundle', 'exec', 'ruby-lsp' }
      --     else
      --       -- Check if ruby-lsp is available in PATH
      --       if vim.fn.executable('ruby-lsp') == 1 then
      --         config.cmd = { 'ruby-lsp' }
      --       else
      --         -- Disable the server if ruby-lsp is not available
      --         config.cmd = nil
      --       end
      --     end
      --   end,
      --   init_options = {
      --     formatter = 'auto',
      --     linters = { 'rubocop' },
      --     featuresConfiguration = {
      --       inlayHint = {
      --         implicitHashValue = true,
      --         implicitRescue = true,
      --       },
      --     },
      --   },
      -- }

      nvim_lsp.kotlin_language_server.setup {}
    end
  }
}
