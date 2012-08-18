# Don't be a sucker, use this vm config

## Installation

### Add your ssh keys

  `ssh-add ~/.ssh/id_rsa`

### Define your Base Box

  `cp definitions/development-vm/definition.rb.example definitions/development-vm/definition.rb`

   Modify the settings to suit your needs.

### One line install (first time)

  `rake install`

### Reset the VM (after first time)

  `rake reset`

### After the box is set up and you modify chef recipies

  `rake vm:provision`
