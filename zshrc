# extra files in ~/.zsh/configs/pre , ~/.zsh/configs , and ~/.zsh/configs/post
# these are loaded first, second, and third, respectively.
_load_settings() {
  _dir="$1"
  if [ -d "$_dir" ]; then
    if [ -d "$_dir/pre" ]; then
      for config in "$_dir"/pre/**/*~*.zwc(N-.); do
        . $config
      done
    fi

    for config in "$_dir"/**/*(N-.); do
      case "$config" in
        "$_dir"/(pre|post)/*|*.zwc)
          :
          ;;
        *)
          . $config
          ;;
      esac
    done

    if [ -d "$_dir/post" ]; then
      for config in "$_dir"/post/**/*~*.zwc(N-.); do
        . $config
      done
    fi
  fi
}
_load_settings "$HOME/.zsh/configs"

for function in ~/.zsh/functions/*; do
  source $function
done

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

[[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Edit the current command with Esc v
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Added primarily for fastlane (https://fastlane.tools/)
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Include binaries installed via e.g. `pip install --user package-name`
export PATH=$PATH:$HOME/.local/bin

# Load the zmv command
autoload -U zmv

[[ -f ~/.nix-profile/etc/profile.d/nix.sh ]] && source ~/.nix-profile/etc/profile.d/nix.sh

export PATH=$PATH:/Library/TeX/texbin

[[ -f /usr/local/opt/asdf/libexec/asdf.sh ]] && . /usr/local/opt/asdf/libexec/asdf.sh

if type "spin" > /dev/null; then
  zstyle ':completion:*' use-cache on
  autoload -Uz compinit && compinit
  source <(spin completion)
fi

# Include hyperlocal machine-specific configuration
[[ -f ~/.zshrc.local.machine ]] && source ~/.zshrc.local.machine

[[ -f /opt/dev/sh/chruby/chruby.sh ]] && { type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; } }

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/styrmis/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/styrmis/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/styrmis/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/styrmis/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/Users/styrmis/miniconda3/etc/profile.d/mamba.sh" ]; then
    . "/Users/styrmis/miniconda3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<
