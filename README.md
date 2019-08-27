# Virtual machine for your development environment

## Tested against

* Host: MacOS Mojave 10.14
* Virtualization Providers: VirtualBox 5.1.14, VMware Fusion 7.1.3
* [Packer^](http://www.packer.io/downloads.html) ~> 1.3.1
* [Vagrant](http://downloads.vagrantup.com/) ~> 2.1.5

(^) Packer is required to build the custom Ubuntu 16.04/18.04 LTS image.

## Installation

### Notes

1. sets the virtual machine to use UTC as your time zone (in `packer/preseed/preseed.cfg`)
2. defaults to an admin user, `vagrant` (in `packer/template.json`)
3. applies no password in sudoers for `vagrant` user (in `packer/provisioning/sudoers.sh`)
4. in Ubuntu 16.04, disables systemd's [PredictableNetworkInterfaceNames](http://www.freedesktop.org/wiki/Software/systemd/PredictableNetworkInterfaceNames/) to work with `vagrant` (in `packer/provisioning/networking_fix.sh`)

You can switch from `systemd` to Upstart on Ubuntu 16.04 by performing the following commands:

```
sudo apt-get install upstart-sysv
sudo update-initramfs -u
```

### Default hardware settings (adjust variables as necessary)

```
cp packer/template.json.example packer/template.json
```

Note: `packer/template.json.example` is based on `Packer 0.6.0`.

  * `cpu_cores`: 4 cores
  * `memory`: 4096 MB
  * `disk_size`: 20140 MB

### Vagrantfile

  * Run `cp Vagrantfile.example Vagrantfile` or create and define your own.
  * Configure and uncomment recipes that you want to cook.
  * Optionally create your own recipes and place in the `cookbooks/custom` directory

### One line install command

When you're ready, run the following depending on your target virtualization provider:

```
rake virtualbox:build_and_provision
rake vmware:build_and_provision
```

## Commonly used vagrant commands

```
  vagrant up        # starts vagrant
  vagrant provision # provisions vm (without restarting)
  vagrant ssh       # SSH into vagrant
  vagrant reload    # restarts vagrant
  vagrant halt      # stops vagrant
  vagrant status    # check to see if vm is running
```

## Running IntelliJ and other X11 apps

On your virtual machine, edit `/etc/ssh/sshd_config` and add the following:

```
X11Forwarding yes
X11DisplayOffset 10
X11UseLocalhost yes
```

Restart the ssh service. Your host machine will need an X11 client. For example, on MacOS, you can use [XQuartz](https://www.xquartz.org/). Then simply run from your terminal:

```
vagrant ssh -- -X
```

The `X` flag enables X11 forwarding for the SSH session. Inside your virtual machine, run the `idea.sh` script from the IntelliJ directory and it should launch an `XQuartz` instance automagically on your host.

## Gotchas

1. If your vm cannot connect to the internet (this typically happens when you switch from one network to another on a VirtualBox vm), run this command:

```
sudo dhclient
```
2. You received the message: "Error creating VM: VBoxManage error: VBoxManage: error: Machine settings file <path_to_vbox> already exists". Installation was left in a bad state. Open VirtualBox, stop and remove the existing VM. Delete this vbox in your VirtualBox directory and re-run the command that failed.

3. On VMware, if HGFS kernel module could not be found, you'll need to re-install VMwareTools. Follow the instructions in the [README](https://github.com/rasa/vmware-tools-patches).

4. You received the message: "Shared folders that Chef requires are missing on the virtual machine.
This is usually due to configuration changing after already booting the
machine. The fix is to run a `vagrant reload` so that the proper shared
folders will be prepared and mounted on the VM." Read the workaround solution [here](https://github.com/mitchellh/vagrant/issues/5199#issuecomment-70603756).

## Credits

Some things taken from [boxcutter/ubuntu](https://github.com/boxcutter/ubuntu) repo. Thanks!
