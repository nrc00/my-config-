# ─── Zsh Configuration ─────────────────────────────────────────────
# File: ~/.zshrc
# Purpose: Interactive shell setup for Arch Linux

# ─── Key Bindings ─────────────────────────────────────────────────
bindkey -e  # Emacs mode (explicit)

bindkey "${terminfo[kdch1]}" delete-char
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}"  end-of-line
bindkey "${terminfo[kpp]}"   history-beginning-search-backward
bindkey "${terminfo[knp]}"   history-beginning-search-forward

# Fallbacks
[[ -z "${terminfo[kdch1]}" ]] && bindkey '^[[3~' delete-char
[[ -z "${terminfo[khome]}" ]] && bindkey '^[[H'  beginning-of-line
[[ -z "${terminfo[kend]}" ]]  && bindkey '^[[F'  end-of-line
[[ -z "${terminfo[kpp]}" ]]   && bindkey '^[[5~' history-beginning-search-backward
[[ -z "${terminfo[knp]}" ]]   && bindkey '^[[6~' history-beginning-search-forward

# ─── Completion System ────────────────────────────────────────────
[[ -d ~/.cache ]] || mkdir -p ~/.cache

autoload -Uz compinit
if [[ -n ~/.cache/zcompdump(#qN.mh+24) ]]; then
    compinit -d ~/.cache/zcompdump
else
    compinit -C -d ~/.cache/zcompdump
fi

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select

# ─── Plugins ──────────────────────────────────────────────────────
[[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

[[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ─── Modern Tools ─────────────────────────────────────────────────
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# ─── Shell Options ────────────────────────────────────────────────
setopt AUTO_CD INTERACTIVE_COMMENTS
setopt EXTENDED_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS INC_APPEND_HISTORY SHARE_HISTORY

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# ─── Environment ──────────────────────────────────────────────────
export EDITOR="nvim"
export VISUAL="${EDITOR}"

# ─── Aliases ──────────────────────────────────────────────────────
alias ls='eza --icons --git'
alias ll='eza -la --icons --git'
alias cat='bat'
alias find='fd'
alias grep='rg'
alias cd='z'

# ─── Functions ────────────────────────────────────────────────────
cr() {
    local file="$1"
    local bin="${file%.c}"
    [[ -f "$file" ]] || { echo "File not found: $file" >&2; return 1; }
    gcc -Wall -Wextra -std=c11 "$file" -o "$bin" && "./$bin" && rm "$bin"
}
