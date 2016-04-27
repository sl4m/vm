# Virtual machine for your development environment

## Tested against

* Host: Mac OS X El Capitan 10.11.4
* Virtualization Providers: VirtualBox 5.0.18, VMware Fusion 7.1.3
* [Packer^](http://www.packer.io/downloads.html) ~> 0.10.0
* [Vagrant](http://downloads.vagrantup.com/) ~> 1.8.1

(^) Packer is required to build the custom Ubuntu 16.04 LTS image.

## Installation

### Notes

1. sets the virtual machine to use Europe/London (aka GMT) as your time zone (in `packer/preseed/preseed.cfg`)
2. defaults to an admin user, `vagrant` (in `packer/template.json`)
3. applies no password in sudoers for `vagrant` user (in `packer/provisioning/sudoers.sh`)
4. disables systemd's [PredictableNetworkInterfaceNames](http://www.freedesktop.org/wiki/Software/systemd/PredictableNetworkInterfaceNames/) to work with `vagrant` (in `packer/provisioning/networking_fix.sh`)

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

### One click install command

When you're ready, run the following depending on your target virtualization provider:

```
rake virtualbox:install
rake vmware:install
```

## Commonly used vagrant commands

```
  vagrant up      # starts vagrant
  vagrant ssh     # SSH into vagrant
  vagrant reload  # restarts vagrant
  vagrant halt    # stops vagrant
```

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

Some things taken from [boxcutter/ubuntu](https://github.com/boxcutter/ubuntu) repo. Thanks guys!
