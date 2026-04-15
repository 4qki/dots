# zsh config

autoload -Uz colors && colors # load colors
stty -ixon # disable C-s and C-q
PS1='%F{green}%m%f:%F{blue}[%F{red}%n%f%F{blue}]%f:%F{magenta}%~%f%F{yellow}$%f '
PS1="%F{cyan}%n%f%F{red}@%f%F{cyan}%m%f %F{green}$%f "
#PS2="%F{9}%n%f%F{cyan}@%f%F{9}%m%f %F{green}$%f "
#PS2="%F{9}%n%f%F{cyan}@%f%F{9}%m%f %F{magenta}%~%f %F{green}$%f "
#PS2="[%~%f] "
PS2="%~%f $ "
#PS1="%F{6}%n%f%F{red}@%f%F{6}%m%f %F{magenta}%~%f %F{green}$%f "
#PS1="%F{cyan}%n@%m%f %F{green}%~%f %F{foreground}$%f "
#PS1="%F{green}%n%F{foreground}@%m %F{green}%~%f$%f "
PS1="%~%f $ "
#PS1="%F{red}λ%f "
#PS1="%F{green}%n@%m %F{green}%~ %F{cyan}$%f "
#PS1="%F{red}[%f%F{yellow}%n%f%F{green}@%f%F{blue}%m%f %F{magenta}%~%f%F{red}]%f%F{cyan}$%f "

setopt autocd # any directory typed is automatically cd-ed into.
setopt interactive_comments # i can do stuff like THIS

bindkey '^P' up-line-or-history   # Ctrl+P
bindkey '^N' down-line-or-history # Ctrl+N
bindkey '^R' history-incremental-search-backward # Ctrl+R
bindkey '^T' transpose-chars      # Ctrl+T

autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd V edit-command-line

# source other programs

eval "$(zoxide init zsh)"
source ~/.config/shell/aliasrc

# smart completion
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=*' 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$ZDOTDIR/.zcompcache"
compinit -d "$ZDOTDIR/.zcompdump"


# basic bindings
bindkey -v # press ESC and see what happens
bindkey "^[[1;5D" backward-word   # Ctrl+Left
bindkey "^[[1;5C" forward-word    # Ctrl+Right
bindkey "^H" backward-word        # Ctrl+H
bindkey "^K" forward-word         # Ctrl+K
bindkey '^A' beginning-of-line    # Ctrl+A
bindkey '^E' end-of-line          # Ctrl+E
bindkey '^U' kill-whole-line      # Ctrl+U
bindkey '^K' kill-line            # Ctrl+K
bindkey '^W' backward-kill-word   # Ctrl+W
bindkey '^?' backward-delete-char # Backspace
bindkey '^D' delete-char          # Ctrl+D
bindkey '^L' clear-screen         # Ctrl+L

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
#zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
}
zle -N zle-line-init

function vi-yank-clip {
    zle vi-yank
    echo "$CUTBUFFER" | xclip -selection clipboard
}

zle -N vi-yank-clip
bindkey -M vicmd 'y' vi-yank-clip
export KEYTIMEOUT=1

# should be last
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
