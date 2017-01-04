#!/bin/bash
set -e

getargs () {
    if [[ $# < 1 ]]; then
        allTheWay
    else
        while getopts "adghoprstv" options; do
            case $options in
                a ) allTheWay;;
                d ) dotfiles;;
                g ) prepare_git;;
                h ) homebrew;;
                o ) osx_defaults;;
                p ) pip_packages;;
                r ) ruby;;
                s ) shell;;
                t ) tmux;;
                v ) vim;;
            esac
        done
     fi
}

allTheWay() {
    dotfiles
    homebrew
    vim
    shell
    prepare_git
    pip_packages
    tmux
    ruby
}

dotfiles() {
    if [[ ! -d ~/projects/dotfiles ]]
    then
        mkdir -p ~/projects
        cd ~/projects
        echo "Cloning dotfiles repo"
        git clone git@github.parsec.apple.com:ldelaveau/dotfiles.git
    fi
    cd ~/projects
    if [[ -f ~/.zshrc || -L ~/.zshrc ]]
    then
        rm ~/.zshrc
    fi
    echo "Linking zshrc"
    ln -s ~/projects/dotfiles/zshrc ~/.zshrc
    if [[ -f ~/.vimrc || -L ~/.vimrc ]]
    then
        rm ~/.vimrc
    fi
    echo "Linking vimrc"
    ln -s ~/projects/dotfiles/vimrc ~/.vimrc
    if [[ -f ~/.tmux.conf || -L ~/.tmux.conf ]]
    then
        rm ~/.tmux.conf
    fi
    echo "Linking tmux.conf"
    ln -s ~/projects/dotfiles/tmux.conf ~/.tmux.conf
    if [[ -f ~/.ctags || -L ~/.ctags ]]
    then
        rm ~/.ctags
    fi
    echo "Linking ctags conf"
    ln -s ~/projects/dotfiles/ctags ~/.ctags

    if uname -s |grep -iq "linux"
    then
        echo "Fixing history issues for debian"
        echo "DEBIAN_PREVENT_KEYBOARD_CHANGES=yes" >> ~/.zshenv
    fi
}

vim() {
    mkdir ~/.vim
    cd ~/.vim
    cp -R ~/projects/dotfiles/vim/* ~/.vim
    mkdir bundle
    cd bundle
    echo "Cloning vundle"
    git clone git@github.com:VundleVim/Vundle.vim.git
}

homebrew() {
    if [[ ! -x /usr/local/bin/brew ]]
    then
	    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
    fi
    /usr/local/bin/brew install tmux ctags python vim python3 go mobile-shell ssh-copy-id coreutils reattach-to-user-namespace cmake git zsh jq
}

shell() {
    chsh -s /bin/zsh ludo
}

pip_packages() {
        pip install -U mercurial thefuck virtualenv virtualenvwrapper
}

prepare_git() {
    echo "Configuring git"
    git config --global user.email ldelaveau@apple.com
    git config --global user.name "Ludovic Delaveau"
    git config --global core.editor "/usr/local/bin/vim"
}

tmux() {
    # installs tmux plugin manager
    if [[ ! -d ~/.tmux/plugins/tpm ]]
    then
        git clone git@github.com:tmux-plugins/tpm.git ~/.tmux/plugins/tpm
    fi
}

ruby() {
    rbenv install 2.3.0
    gem install cocoapods
}

osx_defaults() {
    # Expand save panel by default
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

    # Expand print panel by default
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
}

getargs "$@"
