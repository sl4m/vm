%w(curl libxslt-dev libxml2-dev).each do |p|
  package p do
    action :install
  end
end

rvm_path = "#{ENV['HOME']}/.rvm"

template "#{ENV['HOME']}/.rvmrc" do
  owner ENV['USER']
  action :create_if_missing
  variables :rvm_path => rvm_path
end

bash 'download RVM install script' do
  user ENV['USER']
  code 'curl -L get.rvm.io | bash -s stable'
  returns 1
end

cookbook_file "#{ENV['HOME']}/.gemrc" do
  owner ENV['USER']
  action :create
end

cookbook_file "#{ENV['HOME']}/.rspec" do
  owner ENV['USER']
  action :create
end

cookbook_file "#{ENV['HOME']}/.zsh/rvm.zsh" do
  owner ENV['USER']
  action :create
end

cookbook_file "#{ENV['HOME']}/.zsh/ruby.zsh" do
  owner ENV['USER']
  action :create
end
