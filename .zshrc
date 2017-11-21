export ZSH=$HOME/.oh-my-zsh
ZSH_TMUX_AUTOSTART=true
ZSH_THEME="showsix"
plugins=(brew, extract, git, git-extras, osx, pip, python, tmux, vagrant, vi-mode, web-search, wd)
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
  export PATH="/Library/TeX/texbin:$PATH"
fi

export PATH="~/.bin:$PATH"

if [ -n "$VIRTUAL_ENV" ]; then
  if [ -e "$VIRTUAL_ENV/bin/activate" ]; then
    source "$VIRTUAL_ENV/bin/activate"
  elif [ -e "$VIRTUAL_ENV/Scripts/activate" ]; then
    source "$VIRTUAL_ENV/Scripts/activate"
  fi
else
  if [ -e ~/.virtualenvs/default ]; then
    source ~/.virtualenvs/default
  fi
fi

if [ "$TMUX" = "" ]; then
  exec tmux
fi
