vim.cmd([[
  set encoding=utf-8

  " Leader
  let mapleader = " "

  set backspace=2   " Backspace deletes like most programs in insert mode
  set nobackup
  set nowritebackup
  set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
  set history=50
  set ruler         " show the cursor position all the time
  set showcmd       " display incomplete commands
  set incsearch     " do incremental searching
  set laststatus=2  " Always display the status line
  set autowrite     " Automatically :write before running commands
  set modelines=0   " Disable modelines as a security precaution
  set nomodeline

  " Switch syntax highlighting on, when the terminal has colors
  " Also switch on highlighting the last used search pattern.
  if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
    syntax on
  endif

  set rtp+=/home/spin/.local/share/nvim/plugged/fzf

  filetype plugin indent on

  augroup vimrcEx
    autocmd!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it for commit messages, when the position is invalid, or when
    " inside an event handler (happens when dropping a file on gvim).
    autocmd BufReadPost *
      \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

    " Set syntax highlighting for specific file types
    autocmd BufRead,BufNewFile *.md set filetype=markdown
    autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
    autocmd BufRead,BufNewFile aliases.local,zshrc.local,*/zsh/configs/* set filetype=sh
    autocmd BufRead,BufNewFile gitconfig.local set filetype=gitconfig
    autocmd BufRead,BufNewFile tmux.conf.local set filetype=tmux
    autocmd BufRead,BufNewFile vimrc.local set filetype=vim
  augroup END

  " When the type of shell script is /bin/sh, assume a POSIX-compatible
  " shell for syntax highlighting purposes.
  let g:is_posix = 1

  " Softtabs, 2 spaces
  set tabstop=2
  set shiftwidth=2
  set shiftround
  set expandtab

  " Display extra whitespace
  set list listchars=tab:»·,trail:·,nbsp:·

  " Use one space, not two, after punctuation.
  set nojoinspaces

  " Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
  if executable('ag')
    " Use Ag over Grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in fzf for listing files. Lightning fast and respects .gitignore
    let $FZF_DEFAULT_COMMAND = 'ag --literal --files-with-matches --nocolor --hidden -g ""'

    if !exists(":Ag")
      command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
      nnoremap \ :Ag<SPACE>
    endif
  endif

  " Make it obvious where 80 characters is
  set textwidth=80
  set colorcolumn=+1

  " Numbers
  set number
  set numberwidth=5

  " Switch between the last two files
  nnoremap <Leader><Leader> <C-^>

  " Get off my lawn
  nnoremap <Left> :echoe "Use h"<CR>
  nnoremap <Right> :echoe "Use l"<CR>
  nnoremap <Up> :echoe "Use k"<CR>
  nnoremap <Down> :echoe "Use j"<CR>

  " vim-test mappings
  nnoremap <silent> <Leader>t :TestFile<CR>
  nnoremap <silent> <Leader>s :TestNearest<CR>
  nnoremap <silent> <Leader>l :TestLast<CR>
  nnoremap <silent> <Leader>a :TestSuite<CR>
  nnoremap <silent> <Leader>gt :TestVisit<CR>

  " Run commands that require an interactive shell
  nnoremap <Leader>r :RunInInteractiveShell<Space>

  " Treat <li> and <p> tags like the block tags they are
  let g:html_indent_tags = 'li\|p'

  " Set tags for vim-fugitive
  set tags^=.git/tags

  " Open new split panes to right and bottom, which feels more natural
  set splitbelow
  set splitright

  " Quicker window movement
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-h> <C-w>h
  nnoremap <C-l> <C-w>l

  " Move between linting errors
  nnoremap ]r :ALENextWrap<CR>
  nnoremap [r :ALEPreviousWrap<CR>

  " Map Ctrl + p to open fuzzy find (FZF)
  " All files, including those ignored by git can be searched directly using the
  " :Files command
  nnoremap <c-p> :GFiles<cr>

  " Set spellfile to location that is guaranteed to exist, can be symlinked to
  " Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
  set spellfile=$HOME/.vim-spell-en.utf-8.add

  " Autocomplete with dictionary words when spell check is on
  set complete+=kspell

  " Always use vertical diffs
  set diffopt+=vertical

  let g:better_whitespace_guicolor='#822c0a'

  " Original local configuration below

  if exists('+termguicolors')
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  endif

  set incsearch nohlsearch " do incremental searching without residual highlighting
  set smartcase     " Case insensitive searches, until an uppercase letter is typed

  " Undo highlighting of column 80 added by parent dotfiles
  set colorcolumn=0
  " Also the insertion of line breaks in insert mode by default
  set textwidth=0

  augroup BgHighlight
      autocmd!
      autocmd WinEnter * set cursorline
      autocmd WinLeave * set nocursorline
  augroup END

  " Shortcut to refer to the directory of the current file
  " From https://www.destroyallsoftware.com/file-navigation-in-vim.html
  cnoremap %% <C-R>=expand('%:h').'/'<cr>

  au BufNewFile,BufRead *.py
      \ set tabstop=4 |
      \ set softtabstop=4 |
      \ set shiftwidth=4 |
      \ set textwidth=79 |
      \ set expandtab |
      \ set autoindent |
      \ set fileformat=unix

  au BufNewFile,BufRead *.html
      \ set tabstop=2 |
      \ set softtabstop=2 |
      \ set shiftwidth=2 |
      \ set expandtab |
      \ set autoindent |
      \ set fileformat=unix

  " Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
  let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

  " Index ctags from any project, including those outside Rails
  map <Leader>ct :!ctags -R .<CR>

  " vim-rails tweak: edit alternate file (even if it does not exist)
  command AC :execute "e " . eval('rails#buffer().alternate()')

  let g:neoterm_default_mod = ":vertical"
  let g:neoterm_term_per_tab = 1
  let g:neoterm_autoscroll = 1

  map <Leader><Leader>t :Ttoggle<CR>

  tnoremap <Esc> <C-\><C-n>

  tnoremap <C-h> <C-\><C-N><C-w>h
  tnoremap <C-j> <C-\><C-N><C-w>j
  tnoremap <C-k> <C-\><C-N><C-w>k
  tnoremap <C-l> <C-\><C-N><C-w>l

  " Automatically enter insert mode when switching into a terminal pane
  autocmd BufWinEnter,WinEnter term://* startinsert
  autocmd BufWinLeave,WinLeave term://* stopinsert

  let test#strategy = "neoterm"
  let g:test#preserve_screen = 1

  let test#ruby#rspec#options = {
    \ 'nearest': '',
    \ 'file':    '',
    \ 'suite':   '--fail-fast',
  \}

  " By default assume that we want to target the current window in the current
  " session for tslime commands, like test runs

  let g:tslime_always_current_session=1
  let g:tslime_always_current_window=1
  let g:tmux_panenumber=2

  let g:VimuxOrientation = "h"
  let g:VimuxHeight = "40"

  " Prompt for a command to run
  map <Leader>vp :VimuxPromptCommand<CR>

  " Run last command executed by VimuxRunCommand
  map <Leader>vl :VimuxRunLastCommand<CR>

  " Inspect runner pane
  map <Leader>vi :VimuxInspectRunner<CR>

  " Zoom the tmux runner pane
  map <Leader>vz :VimuxZoomRunner<CR>

  " Close vim tmux runner opened by VimuxRunCommand
  map <Leader>vq :VimuxCloseRunner<CR>

  " vim-ruby customisation


  " Highlight Ruby operators
  let ruby_operators = 1

  let ruby_indent_block_style = 'do'

  " vim-fold-rspec customisation

  let g:fold_rspec_foldlevel = 3       " sets initial open/closed state of all folds (open unless nested more than two levels deep)
  let g:fold_rspec_foldcolumn = 4      " shows a 4-character column on the lefthand side of the window displaying the document's fold structure
  let g:fold_rspec_foldminlines = 3    " disables closing of folds containing two lines or fewer

  " Use the old vim regex engine (version 1, as opposed to version 2, which was
  " introduced in Vim 7.3.969). The Ruby syntax highlighting is significantly
  " slower with the new regex engine.
  "set re=1

  " Colour scheme
  "let g:rehash256 = 1
  " colorscheme molokai

  " Ruby mode for .thor and .etl files
  au BufRead,BufNewFile *.thor set filetype=ruby
  au BufNewFile,BufRead *.etl set filetype=ruby
  au BufNewFile,BufRead *.jbuilder set filetype=ruby
  au BufNewFile,BufRead *.axlsx set filetype=ruby

  " automatically rebalance windows on vim resize
  autocmd VimResized * :wincmd =

  " zoom a vim pane, <C-w>= to re-balance
  nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
  nnoremap <leader>= :wincmd =<cr>

  " jk in rapid succession will bring you out of insert mode
  inoremap jk <esc>
  cnoremap jk <c-c>
  tnoremap jk <C-\><C-n>

  vnoremap v <esc>

  " Quick save shortcut
  noremap <Leader>f :update<CR>

  " Quick tab switching
  nnoremap H gT
  nnoremap L gt

  " Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap ga <Plug>(EasyAlign)

  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)

  " Toggle hard mode
  nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>

  let g:ag_prg="rg --vimgrep"
  set grepprg=rg\ --vimgrep
  set grepformat=%f:%l:%c:%m,%f:%l:%m

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " PROMOTE VARIABLE TO RSPEC LET
  " https://github.com/garybernhardt/dotfiles/blob/master/.vimrc#L202
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  function! PromoteToLet()
    :normal! dd
    " :exec '?^\s*it\>'
    :normal! P
    :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
    :normal ==
  endfunction
  :command! PromoteToLet :call PromoteToLet()
  :map <leader>p :PromoteToLet<cr><Paste>

  " Configure custom shortcuts for moving between git hunks
  nmap ]h <Plug>(GitGutterNextHunk)
  nmap [h <Plug>(GitGutterPrevHunk)

  set updatetime=100

  " Set up bindings for adding blank lines before/after current line
  nnoremap <silent>[<Space> :set paste<CR>m`O<Esc>``:set nopaste<CR>
  nnoremap <silent>]<Space> :set paste<CR>m`o<Esc>``:set nopaste<CR>

  map y <Plug>(highlightedyank)

  " Recommended configuration for EditorConfig
  let g:EditorConfig_exclude_patterns = ['fugitive://.*']

  let g:sneak#label = 0

  nnoremap <leader>b :Buffers<CR>

  com! FormatXML :%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"

  let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \   'python': [
  \       'autopep8',
  \       'isort',
  \   ],
  \   'ruby': [
  \       'rubocop',
  \   ],
  \   'javascript': [
  \       'prettier',
  \   ],
  \   'javascriptreact': [
  \       'prettier',
  \   ],
  \   'typescript': [
  \       'prettier',
  \   ],
  \   'typescriptreact': [
  \       'prettier',
  \   ],
  \}

  let g:ale_ruby_rubocop_executable = 'bundle'

  let g:ale_pattern_options = {
  \ '.rbi$': {'ale_linters': [], 'ale_fixers': []},
  \}

  let g:ale_fix_on_save = 1

  let g:ale_disable_lsp = 1

  nmap <silent> [i <Plug>(ale_previous_wrap)
  nmap <silent> ]i <Plug>(ale_next_wrap)

  " LSP Setup

  nnoremap <leader>rn :lua vim.lsp.buf.rename()<CR>
  nnoremap <leader>gd :lua vim.lsp.buf.definition()<CR>
  nnoremap <C-]> :lua vim.lsp.buf.definition()<CR>
  nnoremap <leader>gi :lua vim.lsp.buf.implementation()<CR>
  nnoremap <leader>fx :lua vim.lsp.buf.code_action()<CR>
  nnoremap <leader>dn <cmd>lua vim.diagnostic.goto_next()<CR>
  nnoremap <leader>dp <cmd>lua vim.diagnostic.goto_prev()<CR>

  " Telescope Setup (fzf replacement)

  nnoremap <leader><leader>p <cmd>Telescope find_files<cr>
  nnoremap <leader><leader>g <cmd>Telescope live_grep<cr>
  nnoremap <leader><leader>b <cmd>Telescope buffers<cr>
  nnoremap <leader><leader>h <cmd>Telescope help_tags<cr>

  " nvim-cmp Setup

  set completeopt=menu,menuone,noselect

  func! YankLastShaForLine()
    :Git blame
    :normal! yiw

    " Need to make blame buffer modifiable to be able to delete it
    :set ma
    :bdelete

    :wincmd p
  endfunc

  " Workflow for quick fixups:
  " Use ys to yank the last SHA for the current line
  " Use yf to form a fixup command
  nmap <leader>ys :call YankLastShaForLine()<CR>
  nmap <leader>yf :Git commit --fixup=<c-r>0

  set inccommand=split

  let g:projectionist_heuristics = {
  \   "engines/deep_understanding/app/*.rb": {"alternate": "engines/deep_understanding/test/{}_test.rb"},
  \   "engines/deep_understanding/test/*_test.rb": {"alternate": "engines/deep_understanding/app/{}.rb"}
  \ }
]])

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
