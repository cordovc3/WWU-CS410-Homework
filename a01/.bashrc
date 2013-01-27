alias com="git commit -a -m"
alias push="git push origin master"

export PS1="\[$(tput bold)\]\[$(tput setaf 1)\]\h\[$(tput setaf 6)\]/\W\[$(tput setaf 3)\]->\[$(tput sgr0)\]"

cd()
{
    builtin cd "${@:-$HOME}" && ls "--color=auto"
}
