# Easy Docker VPN

Manage a Docker based OpenVPN instance with ease.

# Overview

`easy_docker_vpn` is a script that manages an instance of OpenVPN running inside of a Docker container.  The image that it uses is [kylemanna/openvpn](https://hub.docker.com/r/kylemanna/openvpn/) ([source here](https://github.com/kylemanna/docker-openvpn)).  There are two containers in the system:

* ovpn-data - a container based on busybox that specifies a volume for /etc/openvpn
* openvpn - the container that shares the volume from ovpn-data and runs the actual VPN process

# Getting Started

## Set up

### Local install

1. Clone this repository.  Be sure to clone with submodules (`git clone --recursive ...`).
2. Run the following: `eval "$(./easy-docker-vpn/bin/easy_docker_vpn init -)"`.  Put this in your shell initialization for future use.

### Via Docker

1. Pull the image: `docker pull nate/easy-docker-vpn`.
2. Extract the wrapper: `docker run --rm -i easy-docker-vpn cat /wrapper > easy_docker_vpn && chmod +x easy_docker_vpn`

## Create a VPN

Default:

```
$ easy_docker_vpn create -u udp://vpn.domain.com
```

Push an extra route:

```
$ easy_docker_vpn create -u udp://vpn.domain.com -p 'route 172.17.0.1 255.255.255.0' -p "route 10.1.0.0 255.255.0.0"
```

Create a VPN that doesn't route all traffic by default:

```
$ easy_docker_vpn create -N -d -u udp://vpn.domain.com
```

All available options are found by running `docker run --rm -it kylemanna/openvpn ovpn_genconfig -h`:

```
$ docker run --rm -it kylemanna/openvpn ovpn_genconfig -h
Invalid option: -h
usage: /usr/local/bin/ovpn_genconfig [-d]
                  -u SERVER_PUBLIC_URL
                 [-e EXTRA_SERVER_CONFIG ]
                 [-f FRAGMENT ]
                 [-n DNS_SERVER ...]
                 [-p PUSH ...]
                 [-r ROUTE ...]
                 [-s SERVER_SUBNET]

optional arguments:
 -2    Enable two factor authentication using Google Authenticator.
 -a    Authenticate  packets with HMAC using the given message digest algorithm (auth).
 -c    Enable client-to-client option
 -C    A list of allowable TLS ciphers delimited by a colon (cipher).
 -d    Disable NAT routing and default route
 -D    Do not push dns servers
 -m    Set client MTU
 -N    Configure NAT to access external server network
 -t    Use TAP device (instead of TUN device)
 -T    Encrypt packets with the given cipher algorithm instead of the default one (tls-cipher).
 -z    Enable comp-lzo compression.
```

## Issue certificate and configuration

To create a user and accompanying configuration file:

```
$ easy_docker_vpn issue bob
```

To create without a password:

```
$ easy_docker_vpn issue bob nopass
```

# Other Tasks

Each command has help text as well as examples.  For instance, to see the help for `easy_docker_vpn create`, run this command: `easy_docker_vpn help create`.

## VPN Tasks

| Task | Command |
| --- | --- |
| Create VPN | `easy_docker_vpn create ...` |
| Backup VPN Data | `easy_docker_vpn backup ...` |
| Restore from Backup | `easy_docker_vpn restore ...` |
| Destroy VPN | `easy_docker_vpn destroy` |
| Restart VPN | `easy_docker_vpn restart` |
| VPN Status | `easy_docker_vpn status` |
| VPN Management Port | `easy_docker_vpn management` |

## User Tasks

| Task | Command |
| --- | --- |
| Issue User Certificate and Config | `easy_docker_vpn issue ...` |
| List Users | `easy_docker_vpn list` |
| Revoke User Access | `easy_docker_vpn revoke ...` |
