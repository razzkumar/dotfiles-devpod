#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set to superior editing mode
set -o vi

# keybinds
bind -x '"\C-l":clear'

tmux a -t Main || tmux -f ~/.tmux.conf new -s Main

