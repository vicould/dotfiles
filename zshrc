# vars
HISTFILE=~/.zshhistory
HISTSIZE=1000
SAVEHIST=1000

if [ -d /usr/local/bin ]; then
	export PATH=/usr/local/bin:$PATH
fi

if [ -d /usr/local/sbin ]; then
	export PATH=/usr/local/sbin:$PATH
fi

if [ -d /usr/local/mysql/bin ]; then
    export PATH=/usr/local/mysql/bin:$PATH
fi

if [ -d /usr/local/share/python ]; then
	export PATH=/usr/local/share/python:$PATH
fi

if [ -d /usr/local/node_modules/.bin  ]; then
	export PATH=/usr/local/node_modules/.bin:$PATH
fi

if [ -d /usr/texbin  ]; then
	export PATH=/usr/texbin:$PATH
fi

if [ -d ~/utils/bin ]; then
	export PATH=~/utils/bin:$PATH
fi

if [ -d ~/prog/lib/Java ]; then
	export CLASSPATH=~/prog/lib/Java:$CLASSPATH
fi

# various options, see man zshoptions
setopt AUTO_CD
setopt CORRECT
setopt NOCLOBBER
setopt PROMPT_SUBST
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY

# homebrew stuff (completion), and adding functions to the path
fpath=($HOME/.zsh/func $fpath)
typeset -U fpath

# compinit initializes various advanced completions for zsh
autoload -U compinit promptinit colors
compinit -u
promptinit
colors
prompt bart-mod

# completion styles
zstyle ':completion:*' menu select

# key bindings
bindkey "\e[1~" beginning-of-line # Home
bindkey "\e[4~" end-of-line # End
bindkey "\e[5~" beginning-of-history # PageUp
bindkey "\e[6~" end-of-history # PageDown
bindkey "\e[2~" quoted-insert # Ins
bindkey "\e[3~" delete-char # Del
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
bindkey "\e[Z" reverse-menu-complete # Shift+Tab
# for rxvt
bindkey "\e[7~" beginning-of-line # Home
bindkey "\e[8~" end-of-line # End
# # for non RH/Debian xterm, can't hurt for RH/Debian xterm
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
# # for freebsd console
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line

# history
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

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

# aliases
alias ls='ls -FGH'
alias u='cd .. && ls'

# show hidden files
alias dot='show_hidden.sh YES'
alias nodot='show_hidden.sh NO'



