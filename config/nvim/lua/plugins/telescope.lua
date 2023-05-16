return {
  "nvim-telescope/telescope.nvim",
  config = function()
    local actions = require('telescope.actions')

    require('telescope').setup{
      defaults = {
        mappings = {
          n = {
            ["q"] = actions.close
          },
        },
      }
    }
  end
}
