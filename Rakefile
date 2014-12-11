BOX_NAME  = 'vm'
ROOT_PATH = File.expand_path(File.dirname(__FILE__))

provider_builder = lambda do |provider|
  namespace provider do
    desc "Only builds the default #{provider} using packer."
    task :build => ['settings', 'default:create']

    desc "Builds the default #{provider} using packer, and provisions using vagrant."
    task :install => ['settings', 'default:install']

    desc "Reinstalls the default #{provider} using packer, and provisions using vagrant."
    task :reinstall => :install

    desc "Rebuilds from the existing default #{provider}"
    task :rebuild => ['settings', 'default:rebuild']

    desc "Start the #{provider} vm with provisioning"
    task :provision => ['settings', 'vm:provision']

    desc "Start the #{provider} vm (no provisioning)"
    task :up => ['settings', 'vm:up']

    desc "Shuts down #{provider} vm"
    task :down => ['settings', 'vm:down']

    task :settings do
      CONFIGURATOR = build_configurator(provider)
    end
  end
end

provider_builder.call(:virtualbox)
provider_builder.call(:vmware)

namespace :default do
  task :create  => 'box:create'
  task :install => ['box:create', 'vm:start']
  task :rebuild => 'box:rebuild'
end

namespace :box do
  task :create => [:destroy, :remove, :build, :add]

  # destroys the current box
  task :destroy do
    unless `#{vagrant.status_command}`.empty?
      sh vagrant.destroy_command
    end
  end

  # removes the default box from the vagrant box list
  task :remove do
    sh vagrant.remove_command(BOX_NAME) do; end
  end

  # builds the default box using packer
  task :build do
    sh packer.build_command
  end

  # adds the default box to the vagrant box list
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

  task :provision do
    sh vagrant.up_with_provision_command
  end

  task :up do
    sh vagrant.up_command
  end

  task :down do
    sh vagrant.down_command
  end

  task :reload do
    sh vagrant.reload_command
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
  BoxConfigurator.new(type, ENV['VAGRANT_PUBLIC_KEY'])
end
