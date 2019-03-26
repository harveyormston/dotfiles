export ZSH=$HOME/.oh-my-zsh
plugins=(brew extract git git-extras osx pip python tmux vagrant vi-mode web-search wd)
ZSH_DISABLE_COMPFIX=true
ZSH_TMUX_AUTOSTART=true
ZSH_THEME="showsix"
source $ZSH/oh-my-zsh.sh

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

if [ "$machine" "==" "Cygwin" ]; then
  alias open=cygstart
  alias cmd="open /cygdrive/c/WINDOWS/system32/cmd.exe \"/k $(cygpath -w ~/winhome/Local/cmdrc.bat) && cd $(cygpath -w $(pwd))\""
  export PYTHONUNBUFFERED=yes
elif [ "$machine" "==" "Mac" ]; then
  alias top="htop"
  export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
  export PATH="/Library/TeX/texbin:$PATH"
  alias ctags="`brew --prefix`/bin/ctags"
else
  alias top="htop"
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

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    session=remote
else
    session=local
fi

if [ "$TMUX" = "" ] && [ "$session" "==" "local" ]; then
  exec tmux
fi

export EDITOR=/usr/bin/vim

# Use vi mode
bindkey -v

# Vi mode settings
# Better searching in command mode
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

# Beginning search with arrow keys
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search

# Easier, more vim-like editor opening
# `v` is already mapped to visual mode, so we need to use a different key to
# open Vim
bindkey -M vicmd "^V" edit-command-line

# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1

# load iterm2 integration if available
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

echo -e -n "\x1b[\x34 q"
