HOST_NAME = BOX_NAME  = 'vm'
DEFAULT_SSH_PATH = 'packer/keys'
DEFAULT_SSH_PUBLIC_KEY = "#{DEFAULT_SSH_PATH}/vm.pub"
ROOT_PATH = File.expand_path(File.dirname(__FILE__))
LINUX_VERSION_PATH = File.join(ROOT_PATH, 'packer', 'linux_versions')

provider_builder = lambda do |provider|
  namespace provider do
    desc "Only builds the #{provider} base box using packer."
    task :build_base_box => ['settings', 'box:create']

    desc "Builds the #{provider} base box using packer, and provisions using vagrant."
    task :build_and_provision => ['settings', 'box:create', 'vm:start']

    desc "Re-installs and provisions from the existing #{provider} base box"
    task :reinstall => ['settings', 'box:reinstall']

    task :settings => ['setup_ssh'] do
      linux_version
      BOX_CONFIGURATOR = box_configurator(provider)
    end
  end
end

provider_builder.call(:virtualbox)
provider_builder.call(:vmware)

namespace :box do
  task :create => [:destroy, :remove, :build, :add]
  task :reinstall => [:destroy, 'vm:start']

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

task :setup_ssh do
  if !ENV['VAGRANT_PUBLIC_KEY'] && !File.exists?(DEFAULT_SSH_PUBLIC_KEY)
    require "#{ROOT_PATH}/lib/tools/ssh"
    SshKeyGenerator.new(DEFAULT_SSH_PATH).execute
  end
end

def linux_version
  @linux_version ||= (
    require "#{ROOT_PATH}/lib/linux_chooser"
    version = LinuxChooser.new(LINUX_VERSION_PATH).execute
    puts "You chose #{version}."
    version
  )
end

def default_ssh_public_key
  File.read(DEFAULT_SSH_PUBLIC_KEY).strip
end

def packer
  @packer ||= (
    check_configurator
    require "#{ROOT_PATH}/lib/tools/packer"
    Tools::Packer.new(BOX_CONFIGURATOR, linux_version)
  )
end

def vagrant
  @vagrant ||= (
    check_configurator
    require "#{ROOT_PATH}/lib/tools/vagrant"
    Tools::Vagrant.new(BOX_CONFIGURATOR, linux_version)
  )
end

def check_configurator
  raise 'BOX_CONFIGURATOR not set!' unless defined? BOX_CONFIGURATOR
end

def box_configurator(provider_type)
  require "#{ROOT_PATH}/lib/box_configurator"
  public_ssh_key = ENV['VAGRANT_PUBLIC_KEY'] || default_ssh_public_key
  BoxConfigurator.new(provider_type, HOST_NAME, public_ssh_key)
end
