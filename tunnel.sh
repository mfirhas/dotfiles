#!/bin/bash

HOST=
USER=
FLAG1=
PORTFORWARD=
SERVERHOST=
SERVERPORT=
SSH=`which ssh`

if [ -z "$HOST" ] && [ -z "$USER" ] && [ -z "$FLAG1" ] && [ -z "$PORTFORWARD" ] && [ -z "$SERVERHOST" ] && [ -z "$SERVERPORT" ]; then
    read -p 'Host: ' HOST
    read -p 'User: ' USER
    read -p 'Flag: ' FLAG1
    read -p 'Port Forward: ' PORTFORWARD
    read -p 'Server Host: ' SERVERHOST
    read -p 'Server Port: ' SERVERPORT
    echo "connecting..."
    ${SSH} $FLAG1 $PORTFORWARD:$SERVERHOST:$SERVERPORT $USER@$HOST
else
    echo "connecting..."
    ${SSH} $FLAG1 $PORTFORWARD:$SERVERHOST:$SERVERPORT $USER@$HOST
fi