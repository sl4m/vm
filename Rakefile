require 'vagrant'

desc 'Build base box'
task :install => ['box:create', 'vm:configure']

desc 'Rebuild using the Base Box'
task :rebuild => 'box:rebuild'

desc 'Reset the Base Box'
task :reset => 'box:reset'

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

  task :destroy do
    sh 'vagrant destroy'
  end

  task :reset => [:destroy, :create]

  task :rebuild => :destroy do
    sh 'vagrant up'
  end
end

namespace :vm do
  desc 'configure your VM'
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
