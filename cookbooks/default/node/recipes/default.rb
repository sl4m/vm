cookbook_file '/etc/apt/sources.list.d/nodejs.list'

bash 'apt key/apt-get update' do
  code Helper.apt_key('http://keyserver.ubuntu.com:11371/pks/lookup?op=get&search=0xB9316A7BC7917B12')
end

%w(python g++ make).each do |p|
  apt_package p
end

apt_package 'nodejs' do
  action :upgrade
end

cookbook_file Helper.home('.npmrc') do
  owner Helper.user
end

cookbook_file Helper.home('.zsh/npm.zsh') do
  owner Helper.user
end
