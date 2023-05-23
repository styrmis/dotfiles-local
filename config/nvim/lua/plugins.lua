return {
  "christoomey/vim-run-interactive",
  "elixir-lang/vim-elixir",
  "fatih/vim-go",
  "janko-m/vim-test",
  "pangloss/vim-javascript",
  "pbrisbin/vim-mkdir",
  "slim-template/vim-slim",
  "tpope/vim-bundler",
  "tpope/vim-eunuch",
  "tpope/vim-fugitive",
  "tpope/vim-projectionist",
  "tpope/vim-rails",
  "tpope/vim-rake",
  "tpope/vim-repeat",
  "tpope/vim-rhubarb",
  "tpope/vim-surround",
  "tpope/vim-unimpaired",
  "tpope/vim-ragtag",
  "tpope/vim-endwise",
  "tpope/vim-commentary",
  "craigemery/vim-autotag",
  "kassio/neoterm",
  { "jgdavey/tslime.vim", branch = "main" },
  "sjl/gundo.vim",
  "tpope/vim-abolish",
  "tpope/vim-haml",
  "pangloss/vim-javascript",
  "leafgarland/typescript-vim",
  "peitalin/vim-jsx-typescript",
  "yuezk/vim-js",
  "maxmellon/vim-jsx-pretty",
  "jparise/vim-graphql",
  "mattn/emmet-vim",
  "tpope/vim-dispatch",
  "airblade/vim-gitgutter",
  "junegunn/vim-easy-align",
  "christoomey/vim-tmux-navigator",
  "benmills/vimux",
  "justinmk/vim-sneak",
  "ntpeters/vim-better-whitespace",
  { "styrmis/greplace", branch = "allow-blank-filename-list" },
  "machakann/vim-highlightedyank",
  "rking/ag.vim",
  "Chun-Yang/vim-action-ag",
  "kana/vim-textobj-user",
  { "nelstrom/vim-textobj-rubyblock", dependencies = { "kana/vim-textobj-user" } },
  { "kana/vim-textobj-entire", dependencies = { "kana/vim-textobj-user" } },
  "wikitopian/hardmode",
  "ap/vim-css-color",
  {
    "junegunn/fzf",
    build = function()
      vim.cmd([[call fzf#install()]])
    end
  },
  "junegunn/fzf.vim",
  "nvim-lua/plenary.nvim",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-vsnip",
  "hrsh7th/vim-vsnip",
  "petertriho/cmp-git",
  "nvim-lua/popup.nvim",
  "udalov/kotlin-vim", -- Has treesitter support but prefer the plugin
  "dense-analysis/ale",
  {
    'glacambre/firenvim',

    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    cond = not not vim.g.started_by_firenvim,
    build = function()
      require("lazy").load({ plugins = "firenvim", wait = true })
      vim.fn["firenvim#install"](0)
    end,
    config = function()
      vim.g.firenvim_config = {
        localSettings = {
          [ [[.*]] ] = {
            takeover = 'never'
          }
        }
      }
    end
  }
}
