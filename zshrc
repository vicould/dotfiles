#------------------------
# Vars
#------------------------
#
HISTFILE=~/.zshhistory
HISTSIZE=5000
SAVEHIST=5000
if [[ -x /usr/local/bin/vim ]]; then
	export EDITOR="/usr/local/bin/vim"
else
	export EDITOR="/usr/bin/vim"
fi


#------------------------
# Path
#------------------------

[[ -d ~/projects/brew/bin ]] && export PATH=~/projects/brew/bin:$PATH
[[ -d ~/utils/bin ]] && export PATH=~/utils/bin:$PATH
[[ -d ~/bin ]] && export PATH=~/bin:$PATH
[[ -d ~/projects/pot_pourri/bin ]] && export PATH=~/projects/pot_pourri/bin:$PATH
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator
[[ -d ~/.cabal ]] && export PATH=~/.cabal/bin:$PATH 

# ruby
[[ -x /usr/local/bin/rbenv ]] && eval "$(rbenv init -)"

# go
[[ -d ~/projects/gocode ]] && export GOPATH=~/projects/gocode && export PATH=~/projects/gocode/bin:$PATH

# python
export PROJECT_HOME=~/envs
[[ -x `brew --prefix`/bin/virtualenvwrapper.sh ]] && source `brew --prefix`/bin/virtualenvwrapper.sh
[[ -f /usr/share/virtualenvwrapper/virtualenvwrapper.sh ]] && source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
[[ -d ~/projects/pot_pourri ]] && export PYTHONPATH=~/projects/pot_pourri:$PYTHONPATH

#------------------------
# Aliases
#------------------------

alias ls='ls -FGH'
alias ll='ls -l'
alias u='cd .. && ls'
alias wow='git status'

# show hidden files
alias dot='show_hidden.sh YES'
alias nodot='show_hidden.sh NO'

# merde !
alias fuck='eval $(thefuck $(fc -ln -1 | tail -n 1)); fc -R'

alias cleanvim='vim -u NONE -N'

alias gotestcover='GOPATH=${PWD}:${PWD}/_vendor go test -covermode=count -coverprofile=coverage.out'
alias gotest='GOPATH=${PWD}:${PWD}/_vendor go test'
alias gocover='GOPATH=${PWD}:${PWD} go tool cover -html=coverage.out'

#------------------------
# Options
#------------------------

setopt CORRECT
setopt NOCLOBBER
setopt PROMPT_SUBST
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY

# homebrew stuff (completion), and adding functions to the path
fpath=(/usr/local/share/zsh/functions /usr/local/share/zsh/site-functions $fpath)
typeset -U fpath

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# compinit initializes various advanced completions for zsh
autoload -U compinit promptinit colors
compinit -u
promptinit
colors
bindkey -e

branch_prompt () {
    git branch &>/dev/null && echo "[`git branch |grep \"*\" |sed \"s/* //g\"`] "
}

setprompt () {
    PROMPT="%F{green}%m%f %(!.%F{red}#%f.%%) "
    RPROMPT='%(?..%F{red}[%?]%f )%F{magenta}$(branch_prompt)%f%21<...<%3~ %F{cyan}%T%f'
}
setprompt

# completion styles
zstyle ':completion:*' menu select


#------------------------
# Key bindings
#------------------------

bindkey "\e[1~" beginning-of-line # Home
bindkey "\e[4~" end-of-line # End
bindkey "\e[5~" beginning-of-history # PageUp
bindkey "\e[6~" end-of-history # PageDown
bindkey "\e[2~" quoted-insert # Ins
bindkey "\e[3~" delete-char # Del
bindkey "\e[Z" reverse-menu-complete # Shift+Tab
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward


#------------------------
# Macros
#------------------------

# rename current path
namedir() { export $1=$PWD ; : ~$1 }

# Tell the terminal about the working directory at each prompt.
if [ "$TERM_PROGRAM" = "Apple_Terminal" ] && [ -z "$INSIDE_EMACS" ]; then
	update_terminal_cwd() {
		# Identify the directory using a "file:" scheme URL,
		# including the host name to disambiguate local vs.
		# remote connections. Percent-escape spaces.
		local SEARCH=' '
		local REPLACE='%20'
		local PWD_URL="file://$HOSTNAME${PWD//$SEARCH/$REPLACE}"
		printf '\e]7;%s\a' "$PWD_URL"
	}
	autoload add-zsh-hook
	add-zsh-hook chpwd update_terminal_cwd
	update_terminal_cwd
fi

# colored man pages
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
            man "$@"
}
