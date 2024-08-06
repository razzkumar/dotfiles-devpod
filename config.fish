set fish_greeting
set fish_color_normal brcyan
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param '#04cc85'
set fish_color_autosuggestion '#7d7d7d'

# Path variables
# defaults
set VISUAL "nvim"
set EDITOR "nvim"

kubectl completion fish | source

set WORK_DIR "$HOME/Work"

set GOPATH "$HOME/go"
set GOHOME "$HOME/go"

set PATH "$PATH":"$GOPATH/bin"
set PATH "$PATH":"$HOME/go/bin"

set TERM "xterm-256color"
# export KUBECONFIG="$HOME/.kube/config"

starship init fish | source

fish_vi_key_bindings

# Aliases
# https://gist.github.com/freewind/773c3324b5288ff636af
alias gst 'git status'
alias gd 'git diff'
alias lg 'lazygit'
alias fuckyou "git push --force"

function current_branch  
    set ref (git symbolic-ref HEAD 2> /dev/null); or \
    set ref (git rev-parse --short HEAD 2> /dev/null); or return
    echo $ref | sed -e 's|^refs/heads/||'
end

alias ggpull='git pull origin (current_branch)'
alias ggpush='git push origin (current_branch)'

