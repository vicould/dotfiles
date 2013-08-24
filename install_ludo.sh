#!/bin/sh

function allTheWay() {
	dotfiles
	vim
	homebrew
	shell
	prepare_git
}

function dotfiles() {
	if [[ ! -d ~/Documents/geek ]]
	then
		mkdir ~/Documents/geek
		cd ~/Documents/geek
		git clone https://github.siri.apple.com/ldelaveau/dotfiles
	fi
	ln dotfiles/zshrc ~/.zshrc
	ln dotfiles/vimrc ~/.vimrc
	ln dotfiles/gvimrc ~/.gvimrc
	ln dotfiles/tmux.conf ~/.tmux.conf
}

function vim() {
	mkdir ~/.vim
	cd ~/.vim
	cp -R ~/Documents/geek/dotfiles/vim/* ~/.vim
	mkdir bundle
	cd bundle
	git clone https://github.com/tpope/vim-pathogen.git
	git clone git://github.com/Raimondi/delimitMate.git
	git clone git://github.com/scrooloose/nerdcommenter.git
	git clone git://github.com/scrooloose/nerdtree.git
	git clone git://github.com/vim-scripts/FuzzyFinder.git
	git clone https://github.com/ervandew/supertab.git
	git clone https://github.com/msanders/cocoa.vim.git
	git clone https://github.com/msanders/snipmate.vim.git
	git clone https://github.com/robhudson/snipmate_for_django.git
	git clone https://github.com/scrooloose/syntastic.git
	git clone https://github.cocoamm/vim-scripts/CSApprox.git
	hg clone https://bitbucket.org/ns9tks/vim-l9 
}

function homebrew() {
	ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
	brew install tmux macvim reattach-to-user-namespace wget ctags
}

function shell() {
	chsh -s /bin/zsh ludo
}

function prepare_git() {
	git config --global user.email ldelaveau@apple.com
	git config --global user.name "Ludovic Delaveau"
}

allTheWay
