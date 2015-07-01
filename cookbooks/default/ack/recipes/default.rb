apt_package 'ack-grep'

cookbook_file Helper.home('.ackrc') do
  owner Helper.user
end

