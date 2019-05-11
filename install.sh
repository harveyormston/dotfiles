DIR="$( cd "$(dirname "$0")" ; pwd -P  )"

echo Will install friom $DIR
read -p "Are you sure? [y|N]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    cd $DIR

    git submodule update --init --recursive

    git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

    mkdir -p ~/.tmux
    mkdir -p ~/.tmux/plugins

    ln -s -f $DIR/.bash_profile ~/.bash_profile
    ln -s -f $DIR/.bashrc ~/.bashrc
    ln -s -f $DIR/.bin ~/.bin
    ln -s -f $DIR/.git-prompt.sh ~/.git-prompt.sh
    ln -s -f $DIR/.ps1-git.sh ~/.ps1-git.sh
    ln -s -f $DIR/.tmux.conf ~/.tmux.conf
    ln -s -f $DIR/tpm ~/.tmux/plugins/tpm
    ln -s -f $DIR/.vim ~/.vim
    ln -s -f $DIR/.vimrc ~/.vimrc
    ln -s -f $DIR/.zshrc ~/.zshrc
    ln -s -f $DIR/.gitignore_global ~/.gitignore

    cd $DIR/oh-my-zsh/tools
    ./install.sh

    ln -s -f $DIR/showsix.zsh-theme ~/.oh-my-zsh/themes/showsix.zsh-theme

    vim +PluginInstall +qall
fi

