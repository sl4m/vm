package 'curl' do
  action :install
end

rvm_path = "#{ENV['HOME']}/.rvm"
rvm_exec = "#{rvm_path}/bin/rvm"
ruby_version = "ruby-1.9.3-p194"

bash 'download RVM install script' do
  user ENV['USER']
  code 'curl -L get.rvm.io | bash -s stable'
  not_if "test -e #{rvm_exec}"
  returns 1
end

template "#{ENV['HOME']}/.rvmrc" do
  owner ENV['USER']
  action :create_if_missing
  variables :rvm_path => rvm_path
end

bash "install #{ruby_version}" do
  user ENV['USER']
  code "#{rvm_exec} install #{ruby_version}"
  not_if "#{rvm_exec} list | grep \"#{ruby_version}\""
end

bash "set #{ruby_version} as default" do
  user ENV['USER']
  code "#{rvm_exec} alias create default #{ruby_version}"
end

cookbook_file "#{ENV['HOME']}/.gemrc" do
  owner ENV['USER']
  action :create
end
