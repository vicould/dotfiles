#!/bin/sh

function getargs() {
    if [[ $# < 1 ]]; then
        allTheWay
    else
        while getopts "adhpsv" options; do
            case $options in
                a ) allTheWay;;
                d ) dotfiles;;
                h ) homebrew;;
                s ) shell;;
                p ) pip_packages;;
                v ) vim;;
            esac
        done
     fi
}

function allTheWay() {
    dotfiles
    homebrew
    vim
    shell
}

function dotfiles() {
	pushd
	if [[ ! -d ~/projects/geek ]]
	then
		mkdir -p ~/projects/geek
		cd ~/projects/geek
		git clone https://github.com/vicould/dotfiles
	fi
	cd ~/projects/geek
	ln dotfiles/zshrc ~/.zshrc
	ln dotfiles/vimrc ~/.vimrc
	ln dotfiles/gvimrc ~/.gvimrc
	ln dotfiles/tmux.conf ~/.tmux.conf
	popd
}

function vim() {
	mkdir ~/.vim
	cd ~/.vim
	cp -R ~/projects/geek/dotfiles/vim/* ~/.vim
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
	brew install tmux reattach-to-user-namespace wget ctags python vim macvim
}

function shell() {
	chsh -s /bin/zsh ludo
}

function pip_packages() {
        pip install -U pylint pep8 mercurial
}

getargs "$@"
