function _ensure_no_vpn_data() {
	if docker ps -a | grep -q $OVPN_DATA; then
		echo "$OVPN_DATA container found, refusing to continue, use 'easy_docker_vpn destroy' to completely remove vpn"
		exit 1
	fi
}

function _ensure_vpn_data() {
	if ! docker ps -a | grep -q $OVPN_DATA ; then
		echo "No $OVPN_DATA found, use 'easy_docker_vpn create' to create a vpn"
		exit 1
	fi
}

function _restart_vpn() {
	docker stop $OVPN_CONT
	docker rm $OVPN_CONT
	docker run --restart=always --volumes-from $OVPN_DATA --name $OVPN_CONT -d -p 1194:1194/udp --cap-add=NET_ADMIN $OVPN_IMAGE
}

function _start_vpn() {
	docker run --restart=always --volumes-from $OVPN_DATA --name $OVPN_CONT -d -p 1194:1194/udp --cap-add=NET_ADMIN $OVPN_IMAGE
}
