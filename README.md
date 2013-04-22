## Installation

### Define your Base Box

  `cp definitions/development-vm/definition.rb.example definitions/development-vm/definition.rb`

#### Default settings

  * CPU Count: 4 - _If you do not have 4 cores, decrease this number._
  * Memory: 8gb - _If you do not have more than 8gb of RAM, decrease this number._
  * Hard Drive: 20gb

   Modify the settings to suit your needs.

### Vagrantfile

Copy `Vagrantfile.example` as `Vagrantfile` or create your own.

### Add your ssh keys

  `ssh-add ~/.ssh/id_rsa`

### Build and configure your VM

  `rake install`

### Learn the basic vagrant commands

```
  vagrant up     #starts vagrant
  vagrant ssh    #SSH into vagrant
  vagrant reload #restarts vagrant
  vagrant halt   #stops vagrant
```

#### Other Gotchas

   `sudo dhclient` if your vm cannot connect to the internet (this typically happens when you use different WiFi networks)
