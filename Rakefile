require 'vagrant'

desc 'Install the Base Box and VM.'
task :install => ['box:create', 'vm:create']

desc 'Reset the Base Box and VM.'
task :reset => :install

namespace :box do
  task :create => [:remove, :build, :export, :add]

  task :remove do
    sh 'rm -rf skim-vm.box'
    sh 'vagrant box remove skim-vm virtualbox' do; end
  end

  task :build do
    sh 'veewee vbox build skim-vm --force'
  end

  task :export do
    sh 'vagrant package --base skim-vm --output skim-vm.box'
  end

  task :add do
    sh 'vagrant box add skim-vm skim-vm.box'
  end
end

namespace :vm do
  task :create => [:destroy, :up, :provision]

  task :up => :configure do
    sh 'vagrant up --no-provision'
  end

  task :provision => :configure do
    sh 'vagrant provision'
  end

  task :destroy do
    sh 'vagrant destroy -f' do; end
  end

  task :reload => [:down, :open]

  desc 'Shutdown the VM'
  task :down do
    sh 'vagrant halt'
  end

  desc 'Open the VM'
  task :open => [:up, :ssh]

  task :ssh do
    sh 'vagrant ssh'
  end

  desc 'Kill the VM'
  task :kill do
    sh "VBoxManage controlvm #{ENV['VM']} poweroff"
  end

  desc 'List all running VMs'
  task :list do
    sh 'VBoxManage list runningvms'
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
