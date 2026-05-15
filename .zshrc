# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Enable vi mode for zsh command line editing
bindkey -v

# Reduce mode switching delay
export KEYTIMEOUT=1

# source bash aliases
source ~/.dotfiles/.bash_aliases

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# nvm setup
 export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

  # go setup
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export GOPATH="$HOME/go"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

# java openjdk@17
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"

# android studio
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin

# ------ customization -------

# custom script path
export PATH=$PATH:$HOME/.config/custom-scripts

# custom tmux opener
custom-tmux() {
    if [ $# -gt 0 ]; then
        tmux -u "$@"
        return
    fi
    
    if command -v fd &> /dev/null && command -v zoxide &> /dev/null; then
        selected=$(
            {
                zoxide query -l 2>/dev/null | grep "^$HOME/Developer"
                fd --type d --hidden --max-depth 3 . ~/Developer --exec test -d {}/.git \; --print
                fd --type d --max-depth 1 . ~/Developer
            } | awk '!seen[$0]++' | fzf --height=21 --reverse --border --prompt="Developer: "
        )
    elif command -v fd &> /dev/null; then
        selected=$(
            {
                fd --type d --hidden --max-depth 3 . ~/Developer --exec test -d {}/.git \; --print
                fd --type d --max-depth 1 . ~/Developer
            } | awk '!seen[$0]++' | fzf --height=21 --reverse --border --prompt="Developer: "
        )
    else
        selected=$(find ~/Developer -type d \( -name .git -o -name node_modules \) -prune -o -type d -print 2>/dev/null | fzf --height=21 --reverse --border --prompt="Developer: ")
    fi
    
    [ -z "$selected" ] && return 0
    
    session_name=$(basename "$selected" | tr . _)
    
    if ! tmux has-session -t "$session_name" 2>/dev/null; then
        tmux -u new-session -d -s "$session_name" -c "$selected"
    fi
    
    if [ -n "$TMUX" ]; then
        tmux switch-client -t "$session_name"
    else
        tmux -u attach -t "$session_name"
    fi
}
