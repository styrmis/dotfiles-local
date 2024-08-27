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

    -- Not lazy loading, as it stopped working
    build = function()
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
        api_key_cmd = "op read op://Private/ejqfnrdajrdx7c46xvdqngcuiy/credential --no-newline",
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
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  {
    "David-Kunz/gen.nvim",
    opts = {
        model = "llama3", -- The default model to use.
        host = "localhost", -- The host running the Ollama service.
        port = "11434", -- The port on which the Ollama service is listening.
        quit_map = "q", -- set keymap for close the response window
        retry_map = "<c-r>", -- set keymap to re-send the current prompt
        init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
        -- Function to initialize Ollama
        command = function(options)
            local body = {model = options.model, stream = true}
            return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
        end,
        -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
        -- This can also be a command string.
        -- The executed command must return a JSON object with { response, context }
        -- (context property is optional).
        -- list_models = '<omitted lua function>', -- Retrieves a list of model names
        display_mode = "float", -- The display mode. Can be "float" or "split".
        show_prompt = false, -- Shows the prompt submitted to Ollama.
        show_model = false, -- Displays which model you are using at the beginning of your chat session.
        no_auto_close = false, -- Never closes the window automatically.
        debug = false -- Prints errors and the command which is run.
    }
  }
}
