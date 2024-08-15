return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require'nvim-treesitter.configs'.setup {
      highlight = {
        enable = true,
        disable = {},
      },
      ensure_installed = {
        "html",
        "javascript",
        "json",
        "kotlin",
        "lua",
        "python",
        "scss",
        "tsx",
        "toml",
        "vim",
        "yaml",
        "markdown",
        "markdown_inline"
      },
    }
  end
}
