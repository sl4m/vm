## Tested against

* Host: Mac OS X 10.9.4, Ubuntu 14.04 LTS
* Virtualization Providers: VirtualBox 4.3.10, VMware Fusion 7.0.0 (2103067)
* [Packer^](http://www.packer.io/downloads.html) ~> 0.7.1
* [Vagrant](http://downloads.vagrantup.com/) ~> 1.6.5

(^) Packer is required to build the custom Ubuntu image.

## Installation

### Define your Base Box

```
cp packer/template.json.example packer/template.json
```

Note: `packer/template.json.example` is based on `Packer 0.7.1`.

#### Default hardware settings (adjust variables as necessary)

  * `cpu_cores`: 4 cores
  * `memory`: 4096 MB
  * `disk_size`: 20140 MB

### Vagrantfile

  * Copy `Vagrantfile.example` as `Vagrantfile` or create your own.
  * Configure and uncomment recipes that you want to cook.
  * Optionally create your own recipes and place in the `cookbooks/custom` directory

### One click install command

```
rake virtualbox:install
rake vmware:install
```

## The basic vagrant commands

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

2. If you're coming from 1.0.x version of Vagrant, `gem uninstall vagrant` to avoid conflicts with the newer binary package based Vagrant.

3. You received the message: "Error creating VM: VBoxManage error: VBoxManage: error: Machine settings file <path_to_vbox> already exists". Installation was left in a bad state. Open VirtualBox, stop and remove the existing VM. Delete this vbox in your VirtualBox directory and re-run the command that failed.
