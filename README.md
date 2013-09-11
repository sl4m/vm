## Tested against

* Host: Mac OS X 10.8.4
* Virtualization Providers: VirtualBox 4.2.18, VMWare Fusion 6.0.0 (1296151)
* [Packer^](http://www.packer.io/downloads.html) ~> 0.3.7
* [Vagrant](http://downloads.vagrantup.com/) ~> 1.3.1

(^) Packer is required to build the custom Ubuntu image.

## Installation

### Define your Base Box

  `cp packer/template.json.example packer/template.json`

Note: `packer/template.json.example` is based on `Packer 0.3.7`.

#### Default hardware settings (adjust as necessary)

  * CPU Count: 4 cores
  * Memory: 4GB
  * Hard Drive: 20GB

  Modify the settings to suit your needs. VirtualBox settings are under `disk_size`, `vboxmanage` and VMWare settings are under `disk_size`, `vmx_data`.

### Vagrantfile

  * Copy `Vagrantfile.example` as `Vagrantfile` or create your own.
  * Uncomment recipes that you want installed.

### One click install command

```
rake install
```

## Learn the basic vagrant commands

```
  vagrant up      # starts vagrant
  vagrant ssh     # SSH into vagrant
  vagrant reload  # restarts vagrant
  vagrant halt    # stops vagrant
```

## Gotchas

1. If your vm cannot connect to the internet (this typically happens when you switch from one network to another), run this command:

```
sudo dhclient
```

2. If you're coming from 1.0.x version of Vagrant, `gem uninstall vagrant` to avoid conflicts with the newer binary package based Vagrant.

3. You received the message: "Error creating VM: VBoxManage error: VBoxManage: error: Machine settings file <path_to_vbox> already exists". Installation was left in a bad state. Open VirtualBox, stop and remove the existing VM. Delete this vbox in your VirtualBox directory and re-run the command that failed.
