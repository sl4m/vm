# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = 'development-vm'

  config.vm.forward_port 8080, 1234

  config.ssh.forward_agent = true

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = 'cookbooks'
    chef.add_recipe('helper::setup')
    chef.add_recipe('git')
    chef.add_recipe('vim')
    chef.add_recipe('ruby')
    chef.add_recipe('zsh')
    chef.add_recipe('tmux')
    chef.add_recipe('redis')
    chef.add_recipe('xvfb')
    chef.add_recipe('helper::cleanup')
  end

end
