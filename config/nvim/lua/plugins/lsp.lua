return {
  "neovim/nvim-lspconfig",
  config = function()
    local nvim_lsp = require('lspconfig')
    local util = require 'lspconfig.util'

    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    vim.diagnostic.config({
      virtual_text = false,
    })

    nvim_lsp.tsserver.setup {
      capabilities = capabilities,
    }

    nvim_lsp.sorbet.setup {
      cmd = { 'srb', 'tc', '--lsp' },
      capabilities = capabilities,
      filetypes = { 'ruby' },
    }

    nvim_lsp.kotlin_language_server.setup {}
  end
}
