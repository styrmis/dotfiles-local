# dotfiles-local

- Install [Homebrew](https://brew.sh/)
- Temporarily add it to the PATH: `export PATH=$PATH:/opt/homebrew/bin`
- Check out [dotfiles](https://www.github.com/styrmis/dotfiles) and [dotfiles-local](https://www.github.com/styrmis/dotfiles-local) to home directory
- Set up symlinks for dotfiles: `env RCRC=$HOME/dotfiles/rcrc rcup`
- `brew install fzf neovim tmux ripgrep fd 1password-cli reattach-to-user-namespace`
- Install [nvm](https://github.com/nvm-sh/nvm?tab=readme-ov-file#installing-and-updating)
- Install [molokai for iTerm2](https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/schemes/Molokai.itermcolors) if required
- Install [Rectangle app](https://rectangleapp.com/)

### Set up local Git config

#### `~/.gitidentity.local`

```
[user]
  name = Your Name
  email = your-email@example.com
```
