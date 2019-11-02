# -*- mode: sh -*-

if ls --version / 2>/dev/null | grep Stallman >/dev/null; then
  alias ls="ls --color=auto --classify --human-readable --size --group-directories-first"
elif ls -FG / >/dev/null 2>&1; then
  alias ls="ls -bFGks"
else
  echo "Unknown ls implementation, please update ~/.zsh/functions/ls.sh"
fi
