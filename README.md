## Tested against

* Host: Mac OS X 10.8.4
* VirtualBox 4.2.16
* [Vagrant](http://downloads.vagrantup.com/) ~> 1.3.0
* [Packer^](http://www.packer.io/downloads.html) ~> 0.3.6

^ Packer is required to build the custom Ubuntu image.

## Installation

### Define your Base Box

  `cp packer/template.json.example packer/template.json`

Note: `packer/template.json.example` is based on `Packer 0.3.6`.

#### Default hardware settings (adjust as necessary)

  * CPU Count: 4 cores
  * Memory: 4GB
  * Hard Drive: 20GB

  Modify the settings to suit your needs. VirtualBox settings are under `disk_size`, `vboxmanage` and VMWare settings are under `disk_size`, `vmx_data`.

### Vagrantfile

  * Copy `Vagrantfile.example` as `Vagrantfile` or create your own.
  * Uncomment recipes that you want installed.

### One click install command

  `rake install`

### Learn the basic vagrant commands

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
