#!/bin/bash

HOST=
USER=
FLAG1=
PORTFORWARD=
SERVERHOST=
SERVERPORT=
SSH=`which ssh`

if [ ${SSH}="/usr/bin/ssh" ]; then
    if [ -z "$HOST" ]; then read -p 'Host: ' HOST; fi
    if [ -z "$USER" ]; then read -p 'User: ' USER; fi
    if [ -z "$FLAG1" ]; then read -p 'Flag: ' FLAG1; fi
    if [ -z "$PORTFORWARD" ]; then read -p 'Port Forward: ' PORTFORWARD; fi
    if [ -z "$SERVERHOST" ]; then read -p 'Server Host: ' SERVERHOST; fi
    if [ -z "$SERVERPORT" ]; then read -p 'Server Port: ' SERVERPORT; fi
    printf "connecting...\n"
    ${SSH} $FLAG1 $PORTFORWARD:$SERVERHOST:$SERVERPORT $USER@$HOST
else
    printf "ssh not installed!"
fi