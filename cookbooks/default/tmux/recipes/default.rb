tmux_version       = '2.2'
tmux_url           = "https://github.com/tmux/tmux/releases/download/#{tmux_version}/tmux-#{tmux_version}.tar.gz"
tmux_tar           = Helper.home("tmux-#{tmux_version}.tar.gz")
tmux_unpacked_path = Helper.home("tmux-#{tmux_version}")

apt_package 'libevent-dev'

remote_file tmux_tar do
  owner Helper.user
  source tmux_url
  mode '0644'
end

bash 'unpack tmux' do
  user Helper.user
  group Helper.group
  code "tar -xzvf #{tmux_tar} -C #{Helper.home}"
end

file tmux_tar do
  owner Helper.user
  action :delete
end

bash 'install tmux' do
  code <<-EOH
  cd #{tmux_unpacked_path}/
  ./configure && make
  sudo make install
  EOH
end

cookbook_file Helper.home('.tmux.conf') do
  owner Helper.user
  group Helper.group
end
