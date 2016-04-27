#!/bin/bash -eux

if [[ $PACKER_BUILDER_TYPE =~ virtualbox ]]; then
  echo "==> Installing VirtualBox Guest Additions..."
  apt-get -y install dkms
  mount -o loop /home/${SSH_USERNAME}/VBoxGuestAdditions.iso /mnt
  sh /mnt/VBoxLinuxAdditions.run
  umount /mnt
  rm VBoxGuestAdditions.iso
fi
