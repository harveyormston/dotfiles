source ~/.git-prompt.sh

Color_Off="\[\033[0m\]" # Text Reset

# Monokai
MKBLACK="\[\033[0;30m\]"
MKLBLUE="\[\033[0;36m\]"
MKPURPLE="\[\033[0;35m\]"
MKGREEN="\[\033[0;32m\]"
MKORANGE="\[\033[0;33m\]"
MKYELLOW="\[\033[0;37m\]"
MKPINK="\[\033[0;31m\]"

# Various variables you might want for your PS1 prompt instead
Time12h="\T"
Time24h="\t"
Time12a="\@"
PathFull="\w"
PathShort="\W"
NewLine="\n"
Jobs="\j"

export PS1='\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]$(git branch &>/dev/null;\

if [ $? -eq 0 ]; then \
  echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
  if [ "$?" -eq "0" ]; then \
    # @4 - Clean repository - nothing to commit
    echo "'$MKGREEN'"$(__git_ps1 " (%s)"); \
  else \
    # @5 - Changes to working tree
    echo "'$MKPINK'"$(__git_ps1 " {%s}"); \
  fi) '$MKYELLOW$PathShort$Color_Off' \$ "; \
else \
  # @2 - Prompt when not in GIT repo
  echo " '$MKYELLOW$PathShort$Color_Off' \$ "; \
fi)'
