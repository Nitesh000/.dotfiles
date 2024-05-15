# some more ls aliases
alias ls='eza --icons=always'
alias ll='eza -alh --icons=always'
alias tree='eza --tree --icons=always'
alias la='ls -A'
alias l='ls -CF'
alias dev='cd ~/My\ Space/developer/'
alias nvimconf='cd ~/.config/nvim/'
alias g='git'
alias ga='git add'
alias gaa='git add .'
alias _files='xdg-open .'
alias t='tmux -u'
alias ta='tmux -u attach -t'
alias tn='tmux -u new -s'
alias td='tmux detach'
alias tk='tmux kill-session -t'
alias godir='cd ~/go/src/github.com/Nitesh000/'
alias fcd='cd ~ && cd "$(find * -type d | fzf --reverse --height 50% --preview "tree -C {} | head -200")"'
alias vim='nvim'
alias notes='cd ~/My\ Space/developer/notes/'
alias pn='pnpm'

