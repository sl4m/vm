BOX_NAME  = 'skim-vm'
ROOT_PATH = File.expand_path(File.dirname(__FILE__))

namespace :default do
  task :install => ['box:create', 'vm:start']
  task :rebuild => 'box:rebuild'
end

namespace :virtualbox do
  desc 'Builds the default virtualbox using packer, and provisions using vagrant'
  task :install => ['settings', 'default:install']

  desc 'Rebuilds the default virtualbox using packer, and provisions using vagrant'
  task :reinstall => :install

  desc 'Rebuilds from the existing default virtualbox'
  task :rebuild => ['settings', 'default:rebuild']

  desc 'Shuts down virtualbox vm'
  task :down => ['settings', 'vm:down']

  desc 'Start the virtualbox vm'
  task :up => ['settings', 'vm:up']

  task :settings do
    CONFIGURATOR = build_configurator(:virtualbox)
  end
end

namespace :vmware do
  desc 'Builds the default vmware using packer, and provisions using vagrant'
  task :install => ['settings', 'default:install']

  desc 'Rebuilds the default vmware using packer, and provisions using vagrant'
  task :reinstall => :install

  desc 'Rebuilds from the existing default vmware'
  task :rebuild => ['settings', 'default:rebuild']

  desc 'Shuts down vmware vm'
  task :down => ['settings', 'vm:down']

  desc 'Start the virtualbox vm'
  task :up => ['settings', 'vm:up']

  task :settings do
    CONFIGURATOR = build_configurator(:vmware)
  end
end

namespace :box do
  task :create => [:destroy, :remove, :build, :add]

  # destroys the current box
  task :destroy do
    unless `#{vagrant.status_command}`.empty?
      sh vagrant.destroy_command
    end
  end

  # removes the default box from the vagrant list
  task :remove do
    sh vagrant.remove_command(BOX_NAME) do; end
  end

  # builds the default box using packer
  task :build do
    sh packer.build_command
  end

  # adds the default box to the vagrant list
  task :add do
    sh vagrant.add_command(BOX_NAME)
  end

  task :rebuild => [:destroy, 'vm:start']
end

namespace :vm do
  task :configure => [:git_configure]

  task :git_configure do
    require "#{ROOT_PATH}/lib/git_configurator"
    GitConfigurator.new.execute
  end

  task :start => [:configure, :up]

  task :up do
    sh vagrant.up_command
  end

  task :down do
    sh vagrant.down_command
  end
end

def packer
  @packer ||= (
    check_configurator
    require "#{ROOT_PATH}/lib/tools/packer"
    Tools::Packer.new(CONFIGURATOR)
  )
end

def vagrant
  @vagrant ||= (
    check_configurator
    require "#{ROOT_PATH}/lib/tools/vagrant"
    Tools::Vagrant.new(CONFIGURATOR)
  )
end

def check_configurator
  raise 'CONFIGURATOR not set!' unless defined? CONFIGURATOR
end

def build_configurator(type)
  require "#{ROOT_PATH}/lib/box_configurator"
  BoxConfigurator.new(type)
end
