BOX_NAME  = 'skim-vm'
ROOT_PATH = File.expand_path(File.dirname(__FILE__))

desc 'Builds the default box using packer, and provisions using vagrant'
task :install => ['box:create', 'vm:start']

desc 'Rebuilds from the existing default box'
task :rebuild => 'box:rebuild'

desc 'Rebuilds the default box using packer, and provisions using vagrant'
task :reinstall => :install

namespace :box do
  task :create => [:destroy, :remove, :build, :add]

  # destroys the current box
  task :destroy do
    sh 'vagrant destroy'
  end

  # removes the default box from the vagrant list
  task :remove do
    sh "vagrant box remove #{BOX_NAME} virtualbox" do; end
  end

  # builds the default box using packer
  task :build do
    sh 'packer build --force=true --only=virtualbox packer/template.json'
  end

  # adds the default box to the vagrant list
  task :add do
    sh "vagrant box add #{BOX_NAME} #{BOX_NAME}.box"
  end

  task :rebuild => :destroy do
    Rake::Task['vm:start'].invoke
  end

  task :debug_build do
    Rake::Task['box:destroy'].invoke
    Rake::Task['box:remove'].invoke
    ENV['PACKER_LOG'] = 'true'
    Rake::Task['box:build'].invoke
  end
end

namespace :vm do
  task :start => [:configure, :up]

  desc 'configure your VM'
  task :configure => [:git_configure]

  task :git_configure do
    require "#{ROOT_PATH}/tasks/create_git_config"
    Tasks::CreateGitConfig.new.execute
  end

  desc 'start vm (with provisioning)'
  task :up do
    sh 'vagrant up'
  end

  desc 'start vm (no provisioning)'
  task :fast do
    sh 'vagrant up --no-provision'
  end

  desc 'shutdown vm'
  task :down do
    sh 'vagrant halt'
  end
end
