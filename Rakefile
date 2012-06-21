
desc 'Install the Base Box and VM. (first time)'
task :install => ['box:create', 'vm:create']

desc 'Reset the Base Box and VM. (after first time)'
task :reset => ['box:reset', 'vm:reset']

namespace :box do

  task :reset => [:remove, :create]

  task :create => [:build, :export,  :add]

  task :build do
    sh 'veewee vbox build development-vm --force'
  end

  task :export do
    sh 'vagrant package --base development-vm --output development-vm.box'
  end

  task :add do
    sh 'vagrant box add development-vm development-vm.box'
  end

  task :remove do
    sh 'rm development-vm.box'
    sh 'vagrant box remove development-vm'
  end
end

namespace :vm do

  task :reset => [:destroy, :create]

  task :create => [:up, :provision]

  task :destroy do
    sh 'vagrant destroy -f'
  end

  task :reload => [:down, :up]

  desc 'Shutdown the VM'
  task :down do
    sh 'vagrant halt'
  end

  desc 'Kill the VM'
  task :kill do
    sh "VBoxManage controlvm #{ENV['VM']} poweroff"
  end

  desc 'List all running VMs'
  task :list do
    sh 'VBoxManage list runningvms'
  end

  desc 'Open the VM'
  task :open => [:up, :ssh]

  task :up do
    sh 'vagrant up --no-provision'
  end

  task :ssh do
    sh 'vagrant ssh'
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
