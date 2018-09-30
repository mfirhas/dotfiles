#!/bin/bash

HOST=
USER=
PASSWORD=
SSHP=`which sshpass`
if [ -z "$HOST" ] && [ -z "$USER" ] && [ -z "$PASSWORD" ]; then
    read -p 'Host: ' HOST
    read -p 'User: ' USER
    read -sp 'Password: ' PASSWORD
    echo "connecting..."
    ${SSHP} -p $PASSWORD ssh -o StrictHostKeyChecking=no $USER@$HOST
else
    echo "connecting..."
    ${SSHP} -p $PASSWORD ssh -o StrictHostKeyChecking=no $USER@$HOST
fi