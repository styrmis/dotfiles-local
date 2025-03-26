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
    "zk-org/zk-nvim",
    config = function()
      require("zk").setup({
        -- can be "telescope", "fzf", "fzf_lua", "minipick", or "select" (`vim.ui.select`)
        -- it's recommended to use "telescope", "fzf", "fzf_lua", or "minipick"
        picker = "fzf",

        lsp = {
          -- `config` is passed to `vim.lsp.start_client(config)`
          config = {
            cmd = { "zk", "lsp" },
            name = "zk",
            -- on_attach = ...
            -- etc, see `:h vim.lsp.start_client()`
          },

          -- automatically attach buffers in a zk notebook that match the given filetypes
          auto_attach = {
            enabled = true,
            filetypes = { "markdown" },
          },
        },
      })

      local opts = { noremap=true, silent=false }

      -- Create a new note after asking for its title.
      vim.api.nvim_set_keymap("n", "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", opts)

      -- Open notes.
      vim.api.nvim_set_keymap("n", "<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", opts)
      -- Open notes associated with the selected tags.
      vim.api.nvim_set_keymap("n", "<leader>zt", "<Cmd>ZkTags<CR>", opts)

      -- Search for the notes matching a given query.
      vim.api.nvim_set_keymap("n", "<leader>zf", "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>", opts)
      -- Search for the notes matching the current visual selection.
      vim.api.nvim_set_keymap("v", "<leader>zf", ":'<,'>ZkMatch<CR>", opts)
    end
  },
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
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  {
    "David-Kunz/gen.nvim",
    opts = {
        model = "mistral", -- The default model to use.
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
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      debug = true, -- Enable debugging
      -- See Configuration section for rest
    },
    keys = {
      {
        "<leader>ac",
        "<cmd>CopilotChat<cr>",
        desc = "CopilotChat",
      },
      {
        "<leader>ab",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
          end
        end,
        desc = "CopilotChat - Quick chat",
      },
      {
        "<leader>afd",
        "<cmd>CopilotChatFixDiagnostic<cr>", -- Get a fix for the diagnostic message under the cursor.
        desc = "CopilotChat - Fix diagnostic",
      },
      {
        "<leader>ar",
        "<cmd>CopilotChatReset<cr>", -- Reset chat history and clear buffer.
        desc = "CopilotChat - Reset chat history and clear buffer",
      }
    }
  },
}
