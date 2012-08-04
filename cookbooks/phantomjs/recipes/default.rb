package 'libfontconfig1-dev' do
  action :install
end

phantom_package = 'phantomjs-1.6.1-linux-x86_64-dynamic'
phantom_url = "http://phantomjs.googlecode.com/files/#{phantom_package}.tar.bz2"
phantom_tar = File.join(ENV['HOME'], 'phantomjs.tar.bz2')
phantom_home = File.join(ENV['HOME'], '.phantomjs')
phantom_unpacked_path = File.join(ENV['HOME'], phantom_package)

remote_file phantom_tar do
  owner ENV['USER']
  source phantom_url
  mode '0644'
end

directory phantom_home do
  action :delete
  recursive true
end

bash 'unpack phantomjs' do
  user ENV['USER']
  code "tar xvjf #{phantom_tar} -C #{ENV['HOME']}"
end

bash 'move phantomjs' do
  user ENV['USER']
  code "mv #{phantom_unpacked_path} #{phantom_home}"
end

file phantom_tar do
  action :delete
end

cookbook_file "#{ENV['HOME']}/.zsh/phantomjs.zsh" do
  owner ENV['USER']
  action :create
end
