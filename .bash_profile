# set editor
export EDITOR="nvim"
export VISUAL="${EDITOR:-nvim}"

# scripts
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/bin/statusbar:$PATH"

# set manpager
export PAGER="less"

# set cursor
export XCURSOR_THEME="Bibata-Original-Classic"
export XCURSOR_SIZE="24"

# set term
export TERMINAL="alacritty"

# set xdg dirs
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# ~/ cleanup
export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/x11/xinitrc"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export HISTFILE="$XDG_DATA_HOME/history"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/shell/inputrc"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
