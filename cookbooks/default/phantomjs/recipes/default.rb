apt_package 'libfontconfig1-dev'

phantom_package       = 'phantomjs-2.1.1-linux-x86_64'
phantom_url           = "https://bitbucket.org/ariya/phantomjs/downloads/#{phantom_package}.tar.bz2"
phantom_tar           = Helper.home('phantomjs.tar.bz2')
phantom_home          = Helper.home('.phantomjs')
phantom_unpacked_path = Helper.home(phantom_package)

remote_file phantom_tar do
  owner Helper.user
  source phantom_url
  mode '0644'
end

directory phantom_home do
  owner Helper.user
  action :delete
  recursive true
end

bash 'unpack phantomjs' do
  user Helper.user
  group Helper.group
  code "tar -xvjf #{phantom_tar} -C #{Helper.home}"
end

bash 'move phantomjs' do
  user Helper.user
  group Helper.group
  code "mv #{phantom_unpacked_path} #{phantom_home}"
end

file phantom_tar do
  owner Helper.user
  action :delete
end

cookbook_file Helper.home('.zsh/phantomjs.zsh') do
  owner Helper.user
  group Helper.group
end
