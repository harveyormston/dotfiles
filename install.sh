DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DIR

git submodule init
git submodule update

git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

ln -s -f $DIR/.bash_profile ~/.bash_profile
ln -s -f $DIR/.bashrc ~/.bashrc
ln -s -f $DIR/.bin ~/.bin
ln -s -f $DIR/.git-prompt.sh ~/.git-prompt.sh
ln -s -f $DIR/.ps1-git.sh ~/.ps1-git.sh
ln -s -f $DIR/.tmux.conf ~/.tmux.conf
ln -s -f $DIR/.vim ~/.vim
ln -s -f $DIR/.vimrc ~/.vimrc
ln -s -f $DIR/.zshrc ~/.zshrc
ln -s -f $DIR/gitignore_global ~/.gitignore
ln -s -f $DIR/oh-my-zsh ~/.oh-my-zsh
ln -s -f $DIR/showsix.zsh-theme ~/.oh-my-zsh/themes/showsix.zsh-theme

vim +PluginInstall +qall
