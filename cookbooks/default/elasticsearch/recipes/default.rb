elasticsearch_package       = 'elasticsearch-1.1.0'
elasticsearch_url           = "https://download.elasticsearch.org/elasticsearch/elasticsearch/#{elasticsearch_package}.tar.gz"
elasticsearch_tar           = Helper.home('elasticsearch.tar.gz')
elasticsearch_home          = Helper.home('.elasticsearch')
elasticsearch_unpacked_path = Helper.home(elasticsearch_package)

remote_file elasticsearch_tar do
  owner Helper.user
  source elasticsearch_url
  mode '0644'
end

directory elasticsearch_home do
  owner Helper.user
  action :delete
  recursive true
end

bash 'unpack elasticsearch' do
  user Helper.user
  group Helper.group
  code "tar -xzvf #{elasticsearch_tar} -C #{Helper.home}"
end

bash 'move elasticsearch' do
  user Helper.user
  group Helper.group
  code "mv #{elasticsearch_unpacked_path} #{elasticsearch_home}"
end

file elasticsearch_tar do
  owner Helper.user
  action :delete
end

cookbook_file Helper.home('.zsh/elasticsearch.zsh') do
  owner Helper.user
  group Helper.group
end

cookbook_file File.join(elasticsearch_home, 'elasticsearch.yml') do
  owner Helper.user
  group Helper.group
end

cookbook_file '/etc/init.d/elasticsearch' do
  mode 0755
end

bash 'up the amount of open files for elasticsearch' do
  code "sudo sed -i '$ a\* soft nofile 32000' /etc/security/limits.conf"
end

bash 'initialize init daemon script' do
  code 'sudo update-rc.d elasticsearch defaults'
end
