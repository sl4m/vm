## Installation

### Add your ssh keys

  `ssh-add ~/.ssh/id_rsa`

### Define your Base Box

  `cp definitions/development-vm/definition.rb.example definitions/development-vm/definition.rb`

#### Default settings

  * Memory: 8gb - _If you do not have more than 8gb of RAM, decrease this number._
  * Hard Drive: 20gb
  * CPU Count: 4 - _If you do not have 4 cores, decrease this number._

   Modify the settings to suit your needs.

### One line install (first time)

  `rake install`

### Reset the VM (after first time)

  `rake reset`

### After the box is set up and you modify chef recipies

  `rake vm:provision`
