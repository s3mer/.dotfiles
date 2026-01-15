#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
# PS1='[\u@\h \W]\$ '

dim='\[\e[2m\]'
orange='\[\e[38;5;130m\]'
blue='\[\e[38;5;25m\]'
turquoise='\[\e[38;5;23m\]'
end_color='\[\e[0m\]'

#export PS1="${dim}[${end_color}${blue}\u${end_color}${dim}@${end_color}${orange}\h${end_color} ${turquoise}\w${end_color}${dim}]${end_color} \$?\n> "

alias sudo='sudo -v; sudo '
alias pacman='pacman --color always '
alias ping='ping -c4 '
alias largest-files='sudo du -Sh 2> /dev/null | sort -rh | head -15'
alias arch-wiki='chromium /usr/share/doc/arch-wiki/html/en/ 2> /dev/null &'

EC() {
   echo -e '\e[1;33m'code $?'\e[m\n'
}
trap EC ERR

# make backup + add initial absolute path at the end of the file
mk_bak() {
   if [[ $# -eq 1 ]]; then
      shopt -s extglob # need for use variable in case condition
      file_ext=${1##*.}
      common_ext='@(sh|txt|conf|bashrc|service|yaml|toml|hook)'
      case $file_ext in
         $common_ext)
            comment_sign='#'
            ;;
         jsonc)
            comment_sign='//'
            ;;
         lua)
            comment_sign='--'
            ;;
         *)
            comment_sign=''
            ;;
      esac
      cp $1 $HOME/Bak/$(basename $1).bak
      if [[ -n $comment_sign ]]; then
         echo -e "\n$comment_sign $(realpath $1)" >> $_
      fi
   else
      echo 'only one argument is supported'
   fi
}




