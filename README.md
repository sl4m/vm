## Tested against

* Host: Mac OS X 10.8.4, Ubuntu 12.04.4 LTS
* Virtualization Providers: VirtualBox 4.3.6, VMware Fusion 6.0.2 (1398658)
* [Packer^](http://www.packer.io/downloads.html) ~> 0.5.2
* [Vagrant](http://downloads.vagrantup.com/) ~> 1.5.2

(^) Packer is required to build the custom Ubuntu image.

## Installation

### Define your Base Box

```
cp packer/template.json.example packer/template.json
```

Note: `packer/template.json.example` is based on `Packer 0.5.2`.

#### Default hardware settings (adjust as necessary)

  * CPU Count: 4 cores
  * Memory: 4GB
  * Hard Drive: 20GB

  Modify the settings to suit your needs. VirtualBox settings are under `disk_size`, `vboxmanage` and VMware settings are under `disk_size`, `vmx_data`.

### Vagrantfile

  * Copy `Vagrantfile.example` as `Vagrantfile` or create your own.
  * Configure and uncomment recipes that you want cooked.
  * Optionally create your own recipes and place in the `cookbooks/custom` directory

### One click install command

```
rake virtualbox:install
rake vmware:install
```

## Learn the basic vagrant commands

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
