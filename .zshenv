export ZDOTDIR="$HOME/.config/zsh"

[ -f ~/.config/shell/env ] && source ~/.config/shell/env

tty=$(tty)

if [ $tty = "/dev/tty1" ]; then
    startx
fi
