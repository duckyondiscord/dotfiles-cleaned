#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
export PATH="$PATH:/usr/local/bin:$HOME/.local/bin:$HOME/.scripts"


__BASH_TERM="$(tset -q)"


# Environment
source ~/.config/shells/bash/*.env


# TMUX config
source ~/.config/shells/tmux/*.tmux

# Check for TMUX
if [ -z "$TMUX" ] && [ "$__BASH_TERM" != 'linux' ] && [ -x "$(command -v tmux)" ] && [ ! "$__BASH_TMUX_DISABLE" ]; then
    tmux -2 -l
    exit 127
fi


# Disable stuff like ^S and ^Q
stty -ixon


# Functions
source ~/.config/shells/bash/*.functions


# Enable FZF support
if [[ -x "$(command -v fzf)" ]]; then
    source /usr/share/bash-completion/completions/fzf
    source /usr/share/fzf/key-bindings.bash
else
    vecho 'Please install FZF for FZF keybindings'
fi


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
      . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
    fi
fi


source ~/.config/shells/bash/*.aliases


# Enable Vi(M) mode
set -o vi

# cd into a directory with only the name supplied
shopt -s autocd

# Enable extended globbing
shopt -s globstar
shopt -s extglob


export PROMPT_COMMAND='ps_one'

[ "$TERM" == "$__BASH_TERM" ] && tty_autorun


# GPG
GPG_TTY="$(tty)"
export GPG_TTY

export dots='/home/ari/Ari/coding/resources_/dots'
export overlay='/home/ari/Ari/coding/resources_/overlay'
export ntex='/home/ari/Documents/notes/doc.tex'
export npdf='/home/ari/Documents/notes/doc.pdf'
export ndir='/home/ari/Documents/notes'


# Keybinds
bind -f ~/.config/shells/bash/inputrc

for keymap in ~/.config/shells/bash/input/*; do
    vecho "Setting up readline keybinds for $keymap"
    bind -m "$(basename "$keymap")" -f "$keymap" || vecho "Failed to set bindings"
done 2>/dev/null


autorun || vecho 'Autorun failed'

