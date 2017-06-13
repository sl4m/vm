intellij_version       = 'ideaIC-2017.1.4'
intellij_url           = "https://download.jetbrains.com/idea/#{intellij_version}.tar.gz"
intellij_tar           = Helper.home('intellij.tar.gz')
intellij_home          = Helper.home('.intellij')
intellij_unpacked_path = Helper.home('idea-IC')

remote_file intellij_tar do
  owner Helper.user
  source intellij_url
  mode '0644'
end

directory intellij_home do
  owner Helper.user
  action :delete
  recursive true
end

bash 'unpack intellij' do
  user Helper.user
  group Helper.group
  code "tar -xzvf #{intellij_tar} -C #{Helper.home}"
end

bash 'move intellij' do
  user Helper.user
  group Helper.group
  code "mv #{intellij_unpacked_path}* #{intellij_home}"
end

file intellij_tar do
  owner Helper.user
  action :delete
end

cookbook_file Helper.home('.zsh/intellij.zsh') do
  owner Helper.user
  group Helper.group
end
