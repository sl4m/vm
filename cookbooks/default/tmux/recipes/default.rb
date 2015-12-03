apt_package 'tmux'

cookbook_file Helper.home('.tmux.conf') do
  owner Helper.user
  group Helper.group
end
