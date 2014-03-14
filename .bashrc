#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

if [ -f ~/.git-prompt.sh ]; then
    . ~/.git-prompt.sh
fi

if [ -f ~/.svn_bash_completion.sh ]; then
    . ~/.svn_bash_completion.sh
fi

alias ls='ls --color=auto'
alias grep='grep --color=always'
alias ll='ls -al'
alias pacman='sudo pacman'

alias fuck='sudo shutdown -h now'
alias ch='chvt '

alias rm='rm -r'
alias changed="svn status | awk '{print\$2}' | xargs ls -alt"
eval `dircolors $HOME/.dircolors`
source $HOME/.prompt_colors
#PS1='[\u@\h \W]\$ '
#PS1='${RED}[${BRIGHT_BLUE}\u${RED}@${YELLOW}\h${RED}@_@${BRIGHT_GREEN}\W$(__git_ps1 " (%s)")${RED}] ${BRIGHT_YELLOW}\$ ${BRIGHT_CYAN}'

export LC_CTYPE=zh_CN.UTF-8
#export XMODIFIERS="@im=ibus"
#export GTK_IM_MODULE=ibus
#export QT_IM_MODULE=ibus

export SVN_EDITOR=vim
export PATH=~/bin/:$PATH:/home/shizz/.gem/ruby/1.9.1/bin:/home/shizz/tools/android-sdk/tools:/home/shizz/tools/android-sdk/platform-tools:/usr/local/racket/bin

source ~/.bash_prompt
mesg y
#[ -n "$WINDOWID" ] && transset-df -i $WINDOWID >/dev/null

#to make xterm not use bold font
#echo -e "\e[1mA\e[2J\e[7mB\e[m\e[?5h\e[?5l"
#clear
#export HTTP_PROXY=http://google.cn:80
#export HTTPS_PROXY=http://google.cn:80

export PS1='\[\e[1;30m\][\u@\h \[\e[1;31m\]\w\[\e[1;30m\]]\n\$ \[\033[00m\]'
