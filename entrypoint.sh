#!/bin/bash

# if attempting to cat out the wrapper, let that through, otherwise proxy to easy_docker_vpn
if [ "$1" == "cat" ]; then
	eval "$@"
else
	eval "$(/code/bin/easy_docker_vpn init -)"

	easy_docker_vpn "$@"
fi
