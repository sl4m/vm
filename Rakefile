ROOT_PATH = File.expand_path(File.dirname(__FILE__))
BOX_NAME  = 'skim-vm'

desc 'Build base box'
task :install => ['box:create', 'vm:start']

desc 'Rebuild using the Base Box'
task :rebuild => 'box:rebuild'

desc 'Reset the Base Box'
task :reset => 'box:reset'

namespace :box do
  task :create => [:remove, :build, :add]

  task :remove do
    sh "vagrant box remove #{BOX_NAME} virtualbox" do; end
  end

  task :build do
    sh 'packer build --only=virtualbox packer/template.json'
  end

  task :debug_build do
    Rake::Task['box:remove'].invoke
    ENV['PACKER_LOG'] = 'true'
    sh 'packer build --only=virtualbox packer/template.json'
  end

  task :add do
    sh "vagrant box add #{BOX_NAME} #{BOX_NAME}.box"
  end

  task :destroy do
    sh 'vagrant destroy'
  end

  task :rebuild => :destroy do
    sh 'vagrant up'
  end

  task :reset do
    Rake::Task['box:destroy'].invoke
    Rake::Task['box:create'].invoke
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
