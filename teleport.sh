#!/bin/bash

USER=
HOST=
HOSTS=()
HOSTINDEX=
PROXY=
TSH=`which tsh`

while [ ! $# -eq 0 ]; do
	case "$1" in
		--user | -u)
            shift
			USER=$1
            shift
			;;
		--host | -h)
            shift
			HOST=$1
            shift
			;;
        --proxy | -p)
            shift
            PROXY=$1
            shift
            ;;
        --index | -i)
            shift
            HOSTINDEX=$1
            shift
            ;;
        --help)
            printf "flags: \n"
            printf "> -u for user \n"
            printf "> -h for host \n"
            printf "> -p for proxy \n"
            printf "> -i for host index \n"
            exit
            ;;
        *)
            printf "please specify the flags \n"
            printf "flags: -u for user, -h for host, -p for proxy, -i for host index"
            exit
	esac
done

if [ ${TSH}="/usr/local/bin/tsh" ]; then
    if [ ${#HOSTS[@]} -eq 0 ] && [ -z "${HOST}" ]; then read -p 'Host: ' HOST; fi
    if [ -z "$USER" ]; then read -p 'User: ' USER; fi
    if [ -z "$PROXY" ]; then read -p 'Proxy: ' PROXY; fi
    printf "connecting...\n"
    if [ ! -z "$HOST" ]; then
        ${TSH} ssh --proxy=${PROXY} --user=${USER} root@${HOST}
    elif [ ! -z "$HOSTINDEX" ] && [ ! ${#HOSTS[@]} -eq 0 ]; then
        if [ ${HOSTINDEX} -gt $((${#HOSTS[@]}-1)) ]; then
            printf "no proxy found"
            exit
        fi
        ${TSH} ssh --proxy=${PROXY} --user=${USER} root@${HOSTS[HOSTINDEX]}
    else
        printf "host is not set"
        exit
    fi
else
    printf "tsh not installed"
    exit
fi

