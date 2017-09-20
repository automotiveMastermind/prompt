#!/usr/bin/env bash

if [ ! -z "${AM_PROMPT_DEBUG:-}" ]; then
    echo 'post-set-prompt'
fi

# set the prompt
__prompt-set-prompt
__prompt-set-nvm

__dotnet_bash_complete()
{
  local word=${COMP_WORDS[COMP_CWORD]}
  local dotnetPath=${COMP_WORDS[1]}

  local completions=("$(dotnet complete --position ${COMP_POINT} "${COMP_LINE}")")

  COMPREPLY=( $(compgen -W "$completions" -- "$word") )
}

complete -f -F __dotnet_bash_complete dotnet