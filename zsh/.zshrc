# Use powerline
#USE_POWERLINE="true"
# Source manjaro-zsh-configuration
#if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
#  source /usr/share/zsh/manjaro-zsh-config
#fi
# Use manjaro zsh prompt
#if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
#  source /usr/share/zsh/manjaro-zsh-prompt
#fi

export ZDOTDIR=$HOME/.config/zsh
source "$HOME/.config/zsh/.zshrc"

# Rust set-up
source $HOME/.cargo/env

# Run welcome message
#welcomemessage

if [ -e /home/yanboyang713/.nix-profile/etc/profile.d/nix.sh ]; then . /home/yanboyang713/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
