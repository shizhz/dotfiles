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
alias svim='sudo vim'
alias gita='git add'
alias gitc='git commit -m'
alias gitchk='git checkout'
alias gitb='git branch'
alias gitbd='git branch -d'
alias gitf='git fetch' 
alias gitm='git merge' 
alias gitd='git diff' 
alias now='date "+%Y-%m-%d %H:%M:%S %A"'

alias fuck='sudo shutdown -h now'
alias ch='chvt '

alias rm='rm -r'
alias ssh-60='ssh scm-master@es4labs60.emea.nsn-net.net'
alias ssh-64='ssh cs@es4labs64.emea.nsn-net.net'
alias ssh-65='ssh twa-dev@es4labs65.emea.nsn-net.net'
alias ssh-eseew020='ssh twa@eseew020.emea.nsn-net.net'
alias cdt='cd ~/work/source/trunk/'
alias cdb='cd ~/work/source/branch/'
alias changed="svn status | awk '{print\$2}' | xargs ls -alt"
alias ssh-aws="ssh -i ~/.ssh/seki-shi.pem ubuntu@107.21.248.53"
alias jenkins-cli="java -jar /home/shizz/work/source/others/jenkins-cli.jar -s http://localhost:8080/"
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
#export http_proxy='tefipx.tieto.com:8080'
#export https_proxy='tefipx.tieto.com:8080'

source ~/.bash_prompt
mesg y
#[ -n "$WINDOWID" ] && transset-df -i $WINDOWID >/dev/null

#to make xterm not use bold font
#echo -e "\e[1mA\e[2J\e[7mB\e[m\e[?5h\e[?5l"
#clear
#export HTTP_PROXY=http://google.cn:80
#export HTTPS_PROXY=http://google.cn:80

export PS1='\[\e[1;30m\][\u@\h \[\e[1;31m\]\w\[\e[1;30m\]]\n\$ \[\033[00m\]'
alias goagent="~/tools/goagent/local/proxy.py"
