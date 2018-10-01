#!/bin/bash

HOST=
USER=
PASSWORD=
SSHP=`which sshpass`
if [ ${SSHP}="/usr/bin/sshpass" ]; then
    if [ -z "$HOST" ]; then read -p 'Host: ' HOST; fi
    if [ -z "$USER" ]; then read -p 'User: ' USER; fi
    if [ -z "$PASSWORD" ]; then read -sp 'Password: ' PASSWORD; fi
    printf "\nconnecting...\n"
    ${SSHP} -p $PASSWORD ssh -o StrictHostKeyChecking=no $USER@$HOST
else
    printf "sshpass not installed!"
fi