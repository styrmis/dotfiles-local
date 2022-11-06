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