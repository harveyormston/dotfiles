export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="showsix"
plugins=(brew, extract, git, git-extras, osx, python, web-search)
source $ZSH/oh-my-zsh.sh
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
export PATH="/Library/TeX/texbin:$PATH"
export PATH="~/.bin:$PATH"

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

if [ "$machine" "==" "Cygwin" ]; then
  alias cmd="~/win/local/cmder/Cmder.exe"
  alias open=cygstart
  export PYTHONUNBUFFERED=yes
else
  alias top="htop"
fi
