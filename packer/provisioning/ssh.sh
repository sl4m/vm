#!/bin/bash -eux

mkdir /home/${SSH_USERNAME}/.ssh
chmod 700 /home/${SSH_USERNAME}/.ssh
echo ${SSH_PUBLIC_KEY} > /home/${SSH_USERNAME}/.ssh/authorized_keys
chmod 600 /home/${SSH_USERNAME}/.ssh/authorized_keys
chown -R ${SSH_USERNAME}:${SSH_USERNAME} /home/${SSH_USERNAME}/.ssh

sed -i -e 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
sudo systemctl restart ssh
