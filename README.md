## Installation

### Add your ssh keys

  `ssh-add ~/.ssh/id_rsa`

### Define your Base Box
_italic_ Its default memory allocation is just over 8gb, so if you run an air, you'll want to modify that to a lower memory allocation

  `cp definitions/development-vm/definition.rb.example definitions/development-vm/definition.rb`

   Modify the settings to suit your needs.

### One line install (first time)

  `rake install`

### Reset the VM (after first time)

  `rake reset`

### After the box is set up and you modify chef recipies

  `rake vm:provision`
