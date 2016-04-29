#!/bin/bash -eux

if [[ $(lsb_release -rs) == 16.04 ]]; then
  echo '==> Disable PredictableNetworkInterfaceNames'

  echo 'GRUB_CMDLINE_LINUX="biosdevname=0 net.ifnames=0"' >> /etc/default/grub
  grub-mkconfig -o /boot/grub/grub.cfg

  NETWORK_INTERFACES=/etc/network/interfaces

  # clobber first, then append
  echo '' > ${NETWORK_INTERFACES}

  echo 'source /etc/network/interfaces.d/*' >> ${NETWORK_INTERFACES}
  echo 'auto lo' >> ${NETWORK_INTERFACES}
  echo 'iface lo inet loopback' >> ${NETWORK_INTERFACES}
  echo 'auto eth0' >> ${NETWORK_INTERFACES}
  echo 'iface eth0 inet dhcp' >> ${NETWORK_INTERFACES}
  echo 'auto eth1' >> ${NETWORK_INTERFACES}
  echo 'iface eth1 inet manual' >> ${NETWORK_INTERFACES}
fi
