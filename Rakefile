
desc 'Install the VM from scratch. Very long the first time'
task :default => :install

desc 'Install the VM from scratch. Very long the first time'
task :install => ['box:create', 'vm:reset']

namespace :box do

  desc 'Create the vagrant box (the base vm) and install it'
  task :create => [:build, :export,  :add]

  desc 'Destroy the vagrant box and recreate it'
  task :reset => [:remove, :create]

  task :build do
    sh 'veewee vbox build development-vm --force'
  end

  task :export do
    sh 'vagrant basebox export development-vm --force'
  end

  task :add do
    sh 'vagrant box add development-vm development-vm.box'
  end

  task :remove do
    sh 'vagrant box remove development-vm'
  end
end

namespace :vm do

  desc 'Reset the VM (destroy and recreate)'
  task :reset => [:destroy, :up, :provision]

  task :destroy do
    sh 'vagrant destroy -f'
  end

  task :reload => [:down, :up]

  task :down do
    sh 'vagrant halt'
  end

  task :up do
    sh 'vagrant up --no-provision'
  end

  task :provision => :configure do
    sh 'vagrant provision'
  end

  task :configure => [:git_configure]

  task :git_configure do
    unless git_configured?
      create_git_config_file
    end
  end

  def git_configured?
    File.exists?(git_config_file)
  end

  def create_git_config_file
    print 'Please enter your full name (for Git config): '
    @full_name = STDIN.gets.strip
    print 'Please enter your email (for Git config): '
    @email = STDIN.gets.strip
    print 'Please enter your Github username (for Git config): '
    @username = STDIN.gets.strip
    require 'erb'
    template_contents = File.open(git_config_template).read
    git_config_contents = ERB.new(template_contents).result(binding)
    FileUtils.mkpath(git_config_dir)
    File.open(git_config_file, 'w') {|f| f.write(git_config_contents)}
  end

  def git_cookbook
    File.expand_path(File.join('..', 'cookbooks', 'git'), __FILE__)
  end

  def git_config_dir
    File.join(git_cookbook, 'files', 'default')
  end

  def git_config_file
    File.join(git_config_dir, '.gitconfig')
  end

  def git_config_template
    File.join(git_cookbook, 'templates', 'default', '.gitconfig.erb')
  end
end
