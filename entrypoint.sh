#!/bin/bash -e

# generate host keys if not present
ssh-keygen -A

mkdir /run/sshd -p

# do not detach (-D), log to stderr (-e), passthrough other arguments
echo "Starting sshd"
exec /usr/sbin/sshd -D -e "$@"
