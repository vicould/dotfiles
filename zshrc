#------------------------
# Vars
#------------------------
#
HISTFILE=~/.zshhistory
HISTSIZE=5000
SAVEHIST=5000


#------------------------
# Path
#------------------------

[[ -d /usr/local/bin ]] && export PATH=/usr/local/bin:$PATH
[[ -d /usr/local/sbin ]] && export PATH=/usr/local/sbin:$PATH
[[ -d /usr/local/mysql/bin ]] && export PATH=/usr/local/mysql/bin:$PATH
[[ -d /usr/local/share/python ]] && export PATH=/usr/local/share/python:$PATH
[[ -d /usr/local/node_modules/.bin  ]] && export PATH=/usr/local/node_modules/.bin:$PATH
[[ -d /usr/texbin  ]] && export PATH=/usr/texbin:$PATH
[[ -d ~/utils/bin ]] && export PATH=~/utils/bin:$PATH
[[ -d ~/prog/lib/Java ]] && export CLASSPATH=~/prog/lib/Java:$CLASSPATH
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator
# postgres app
[[ -d /Applications/Postgres.app/Contents/MacOs/bin ]] && export PATH=/Applications/Postgres.app/Contents/MacOS/bin:$PATH

eval "$(rbenv init -)"


#------------------------
# Aliases
#------------------------

alias ls='ls -FGH'
alias ll='ls -l'
alias u='cd .. && ls'

# show hidden files
alias dot='show_hidden.sh YES'
alias nodot='show_hidden.sh NO'


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
fpath=($HOME/.zsh/func /usr/local/share/zsh-completions $fpath)
typeset -U fpath

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# compinit initializes various advanced completions for zsh
autoload -U compinit promptinit colors
compinit -u
promptinit
colors
bindkey -e

setprompt () {
    PROMPT="%F{green}%m%f %(!.%F{red}#%f.%%) "
    RPROMPT="%(?..%F{red}[%?]%f )%21<...<%3~ %F{cyan}%T%f"
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

