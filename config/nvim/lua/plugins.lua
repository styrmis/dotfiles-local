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
  },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup({
        api_key_cmd = "op read op://private/xqv6aprdynfhpbufrglnyllo3u/credential --no-newline",
        yank_register = "+",
        edit_with_instructions = {
          diff = false,
          keymaps = {
            accept = "<C-y>",
            toggle_diff = "<C-d>",
            toggle_settings = "<C-o>",
            cycle_windows = "<Tab>",
            use_output_as_input = "<C-i>",
          },
        },
        chat = {
          welcome_message = WELCOME_MESSAGE,
          loading_text = "Loading, please wait ...",
          question_sign = "", -- 🙂
          answer_sign = "ﮧ", -- 🤖
          max_line_length = 120,
          sessions_window = {
            border = {
              style = "rounded",
              text = {
                top = " Sessions ",
              },
            },
            win_options = {
              winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
            },
          },
          keymaps = {
            close = { "<C-c>" },
            yank_last = "<C-y>",
            yank_last_code = "<C-k>",
            scroll_up = "<C-u>",
            scroll_down = "<C-d>",
            toggle_settings = "<C-o>",
            new_session = "<C-n>",
            cycle_windows = "<Tab>",
            select_session = "<Space>",
            rename_session = "r",
            delete_session = "d",
          },
        },
        popup_layout = {
          relative = "editor",
          position = "50%",
          size = {
            height = "80%",
            width = "80%",
          },
        },
        popup_window = {
          filetype = "chatgpt",
          border = {
            highlight = "FloatBorder",
            style = "rounded",
            text = {
              top = " ChatGPT ",
            },
          },
          win_options = {
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
        },
        popup_input = {
          prompt = "  ",
          border = {
            highlight = "FloatBorder",
            style = "rounded",
            text = {
              top_align = "center",
              top = " Prompt ",
            },
          },
          win_options = {
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
          submit = "<C-g>",
        },
        settings_window = {
          border = {
            style = "rounded",
            text = {
              top = " Settings ",
            },
          },
          win_options = {
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
        },
        openai_params = {
          model = "gpt-3.5-turbo",
          frequency_penalty = 0,
          presence_penalty = 0,
          max_tokens = 300,
          temperature = 0,
          top_p = 1,
          n = 1,
        },
        openai_edit_params = {
          model = "code-davinci-edit-001",
          temperature = 0,
          top_p = 1,
          n = 1,
        },
        actions_paths = {},
        predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv",
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  }
}
