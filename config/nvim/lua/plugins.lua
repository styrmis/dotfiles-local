return {
  "janko-m/vim-test",
  "pangloss/vim-javascript",
  "pbrisbin/vim-mkdir",
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
  "kassio/neoterm",
  { "jgdavey/tslime.vim", branch = "main" },
  "tpope/vim-abolish",
  "leafgarland/typescript-vim",
  "peitalin/vim-jsx-typescript",
  "yuezk/vim-js",
  "maxmellon/vim-jsx-pretty",
  "jparise/vim-graphql",
  "mattn/emmet-vim",
  "tpope/vim-dispatch",
  "airblade/vim-gitgutter",
  "junegunn/vim-easy-align",
  {
    "christoomey/vim-tmux-navigator"
  },
  "justinmk/vim-sneak",
  "ntpeters/vim-better-whitespace",
  { "styrmis/greplace", branch = "allow-blank-filename-list" },
  "machakann/vim-highlightedyank",
  "rking/ag.vim",
  "Chun-Yang/vim-action-ag",
  "kana/vim-textobj-user",
  { "nelstrom/vim-textobj-rubyblock", dependencies = { "kana/vim-textobj-user" } },
  { "kana/vim-textobj-entire", dependencies = { "kana/vim-textobj-user" } },
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
  "petertriho/cmp-git",
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
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "ruff_format" },
          ruby = { "rubocop" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
        formatters = {
          ruff_format = { require_cwd = true },
          rubocop = { require_cwd = true },
        },
      })
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
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
  {
    "coder/claudecode.nvim",
    opts = {
      terminal = {
        split_side = "right",
        split_width_percentage = 0.5,
        provider = "native", -- or "snacks"
      }
    },
    config = true,
    keys = {
      { "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>cs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      { "<leader>cf", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add file to Claude context" },
    },
  }
}
