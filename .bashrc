# prompt
PS1="\w $ "

# zoxide
eval "$(zoxide init bash)"

# alias
alias ls="ls --color=auto"
alias ll="ls -l"
alias la="ls -la"
alias grep="grep --color=auto"
alias vi="nvim"
alias vim="nvim"
alias p="doas pacman"
alias cd="z"
alias mk="doas make install"
alias mkdir="mkdir -pv"
alias mv="mv -iv"
alias rsync="rsync -vrPlu"
alias g="git"

# enable completion with doas
complete -F _command doas

# auto cd when entering directory
shopt -s autocd
