alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias setup='/bin/bash ~/.bin/setup.sh'

alias geach='git submodule foreach'
alias gpull='git submodule foreach git pull'
alias gfetch='git submodule foreach git fetch'
alias gclean='git submodule foreach git clean'
alias greset='git submodule foreach git reset'
alias gbranch='git submodule foreach git branch'
alias gstatus='git submodule foreach git status'
alias gcheckout='git submodule foreach git checkout'

source ~/.bash_completion.d/complete_alias

complete -F _complete_alias config
complete -F _complete_alias geach
complete -F _complete_alias gpull
complete -F _complete_alias gfetch
complete -F _complete_alias gclean
complete -F _complete_alias greset
complete -F _complete_alias gbranch
complete -F _complete_alias gstatus
complete -F _complete_alias gcheckout
