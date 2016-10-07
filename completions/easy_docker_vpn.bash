_easy_docker_vpn() {
  local word="${COMP_WORDS[COMP_CWORD]}"

  if [ "$COMP_CWORD" -eq 1 ]; then
    COMPREPLY=( $(compgen -W "$(easy_docker_vpn commands)" -- "$word") )
  else
    local completions="$(easy_docker_vpn completions "${COMP_WORDS[@]:1}")"
    COMPREPLY=( $(compgen -W "$completions" -- "$word") )
  fi
}

complete -o default -F _easy_docker_vpn easy_docker_vpn
