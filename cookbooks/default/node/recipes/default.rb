apt_sources_list_file 'nodejs.list'

bash 'apt key/apt-get update' do
  code Helper.apt_key('http://keyserver.ubuntu.com:11371/pks/lookup?op=get&search=0xB9316A7BC7917B12')
end

%w(python g++ make).each do |p|
  apt_package p
end

apt_package 'nodejs' do
  action :upgrade
end

user_cookbook_file '.npmrc'

zsh_file 'npm'
