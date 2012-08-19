%w(curl libxslt-dev libxml2-dev).each do |p|
  package p
end

user_template '.rvmrc' do
  variables :rvm_path => Helper.home('.rvm')
end

user_bash 'download RVM install script' do
  code 'curl -L get.rvm.io | bash -s stable'
  returns 1
end

user_cookbook_file '.gemrc'

user_cookbook_file '.rspec'

zsh_file 'rvm'

zsh_file 'ruby'
