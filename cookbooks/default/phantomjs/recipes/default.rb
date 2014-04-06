apt_package 'libfontconfig1-dev'

phantom_package = 'phantomjs-1.9.7-linux-x86_64'
phantom_url = "https://bitbucket.org/ariya/phantomjs/downloads/#{phantom_package}.tar.bz2"
phantom_tar = Helper.home('phantomjs.tar.bz2')
phantom_home = Helper.home('.phantomjs')
phantom_unpacked_path = Helper.home(phantom_package)

user_remote_file phantom_tar do
  source phantom_url
  mode '0644'
end

user_directory phantom_home do
  action :delete
  recursive true
end

user_bash 'unpack phantomjs' do
  code "tar -xvjf #{phantom_tar} -C #{Helper.home}"
end

user_bash 'move phantomjs' do
  code "mv #{phantom_unpacked_path} #{phantom_home}"
end

user_file phantom_tar do
  action :delete
end

zsh_file 'phantomjs'
