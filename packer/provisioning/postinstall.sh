apt-get -y update
apt-get -y upgrade
apt-get -y install linux-headers-$(uname -r) build-essential

if test -f .vbox_version ; then
  echo "installing VirtualBox Guest Additions..."
  apt-get -y install dkms
  mount -o loop /home/vagrant/VBoxGuestAdditions.iso /mnt
  sh /mnt/VBoxLinuxAdditions.run
  umount /mnt
  rm VBoxGuestAdditions.iso
else
  echo "installing VMWare Tools..."
  mount -o loop /home/vagrant/VMWareTools.iso /mnt
  tar xzvf /mnt/VMwareTools-*.tar.gz -C /tmp/
  /tmp/vmware-tools-distrib/vmware-install.pl -d
  umount /mnt
  /usr/bin/vmware-config-tools.pl -d
fi

echo "setup sudo to allow no-password sudo for 'admin'"
groupadd -r admin
usermod -a -G admin vagrant
cp /etc/sudoers /etc/sudoers.orig
sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=admin' /etc/sudoers
sed -i -e '/Defaults\s\+env_reset/a Defaults\tenv_keep+=SSH_AUTH_SOCK' /etc/sudoers
sed -i -e '/Defaults\s\+env_reset/a Defaults\tenv_keep+=PATH' /etc/sudoers
sed -i -e 's/%admin ALL=(ALL) ALL/%admin ALL=NOPASSWD:ALL/g' /etc/sudoers

# apt-get install various things necessary (e.g., NFS client, Ruby)
# and remove optional things to trim down the machine.
apt-get -y install nfs-common openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev autoconf libc6-dev libncurses5-dev automake libtool bison pkg-config libgdbm-dev libffi-dev ruby-dev
apt-get clean

# Create .ssh directory
mkdir /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh

# Remove items used for building, since they aren't needed anymore
apt-get -y remove linux-headers-$(uname -r)
apt-get -y autoremove

# Removing leftover leases and persistent rules
echo "cleaning up dhcp leases"
rm /var/lib/dhcp/*

# Make sure Udev doesn't block our network
# http://6.ptmc.org/?p=164
echo "cleaning up udev rules"
rm -rf /etc/udev/rules.d/70-persistent-net.rules
mkdir /etc/udev/rules.d/70-persistent-net.rules
rm -rf /dev/.udev/
rm /lib/udev/rules.d/75-persistent-net-generator.rules

echo "Adding a 2 sec delay to the interface up, to make the dhclient happy"
echo "pre-up sleep 2" >> /etc/network/interfaces

# Zero out the free space to save space in the final image:
echo "Zeroing device to make space..."
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

# Sync to ensure that the delete completes before this moves on.
sync
sync
sync

exit
