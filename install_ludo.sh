#!/bin/sh

function getargs() {
    if [[ $# < 1 ]]; then
        allTheWay
    else
        while getopts "adghpsv" options; do
            case $options in
                a ) allTheWay;;
                d ) dotfiles;;
		g ) prepare_git;;
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
}

function vim() {
    mkdir ~/.vim
    cd ~/.vim
    cp -R ~/projects/geek/dotfiles/vim/* ~/.vim
    mkdir bundle
    cd bundle
    git clone git://github.com/Raimondi/delimitMate.git
    git clone git://github.com/scrooloose/nerdcommenter.git
    git clone git://github.com/scrooloose/nerdtree.git
    git clone git://github.com/vim-scripts/FuzzyFinder.git
    git clone https://github.com/MarcWeber/vim-addon-mw-utils.git
    git clone https://github.com/ervandew/supertab.git
    git clone https://github.com/garbas/vim-snipmate.git
    git clone https://github.com/honza/vim-snippets.git
    git clone https://github.com/majutsushi/tagbar.git
    git clone https://github.com/msanders/cocoa.vim.git
    git clone https://github.com/robhudson/snipmate_for_django.git
    git clone https://github.com/scrooloose/syntastic.git
    git clone https://github.com/tomtom/tlib_vim.git
    git clone https://github.com/tpope/vim-fugitive.git
    git clone https://github.com/tpope/vim-pathogen.git
    git clone https://github.com/xolox/vim-easytags.git
    git clone https://github.com/xolox/vim-misc.git
    hg clone https://bitbucket.org/ns9tks/vim-l9 
}

function homebrew() {
    ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
    brew install tmux reattach-to-user-namespace wget ctags python vim macvim
    mkdir -p ~/.zsh/func
    ln -s "$(brew --prefix)/Library/Contributions/brew_zsh_completion.zsh" ~/.zsh/func/_brew
}

function shell() {
    chsh -s /bin/zsh ludo
}

function pip_packages() {
        pip install -U pylint pep8 mercurial
}

function prepare_git() {
    git config --global user.email ldelaveau@apple.com
    git config --global user.name "Ludovic Delaveau"
}

getargs "$@"
