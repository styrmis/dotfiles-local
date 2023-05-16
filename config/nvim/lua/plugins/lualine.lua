return {
  "hoob3rt/lualine.nvim",
  config = function()
    local status, lualine = pcall(require, "lualine")

    if (not status) then return end

    lualine.setup {
      options = {
        icons_enabled = true,
        theme = 'molokai',
        section_separators = {'', ''},
        component_separators = {'', ''},
        disabled_filetypes = {}
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'filename'},
        lualine_c = {},
        lualine_x = {
          { 'diagnostics', sources = {"nvim_lsp", "ale"}, symbols = {error = 'E:', warn = 'W:', info = 'I:', hint = 'H:'} },
          'filetype'
        },
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      extensions = {'fugitive'}
    }
  end
}
