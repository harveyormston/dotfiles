# Set architecture flags
export ARCHFLAGS="-arch x86_64"
# Ensure user-installed binaries take precedence
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=~/.bin:$PATH

# Load .bashrc if it exists
test -f ~/.bashrc && source ~/.bashrc

# vi key mapping
set -o vi

# git prompt
source ~/.git-completion.bash
source ~/.git-prompt.sh
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS="yes"
source ~/.ps1-git.sh

# colors
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -GFh'
