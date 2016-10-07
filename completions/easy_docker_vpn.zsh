if [[ ! -o interactive ]]; then
    return
fi

compctl -K _easy_docker_vpn easy_docker_vpn

_easy_docker_vpn() {
  local word words completions
  read -cA words
  word="${words[2]}"

  if [ "${#words}" -eq 2 ]; then
    completions="$(easy_docker_vpn commands)"
  else
    completions="$(easy_docker_vpn completions "${word}")"
  fi

  reply=("${(ps:\n:)completions}")
}
