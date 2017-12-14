#!/bin/bash

set -e

service ssh start

if [ -n "$SSH_PUBKEY" ]; then
  SSH_DIR=/home/ssh_user/.ssh
  mkdir -p $SSH_DIR

  echo $SSH_PUBKEY >> $SSH_DIR/authorized_keys

  chmod 700 $SSH_DIR
  chmod 600 $SSH_DIR/authorized_keys
  chown ssh_user:ssh_user -R $SSH_DIR
fi

httpd-foreground
