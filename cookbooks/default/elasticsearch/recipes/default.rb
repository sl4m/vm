elasticsearch_package = 'elasticsearch-1.1.0'
elasticsearch_url = "https://download.elasticsearch.org/elasticsearch/elasticsearch/#{elasticsearch_package}.tar.gz"
elasticsearch_tar = Helper.home('elasticsearch.tar.gz')
elasticsearch_home = Helper.home('.elasticsearch')
elasticsearch_unpacked_path = Helper.home(elasticsearch_package)

user_remote_file elasticsearch_tar do
  source elasticsearch_url
  mode '0644'
end

user_directory elasticsearch_home do
  action :delete
  recursive true
end

user_bash 'unpack elasticsearch' do
  code "tar -xzvf #{elasticsearch_tar} -C #{Helper.home}"
end

user_bash 'move elasticsearch' do
  code "mv #{elasticsearch_unpacked_path} #{elasticsearch_home}"
end

user_file elasticsearch_tar do
  action :delete
end

zsh_file 'elasticsearch'

cookbook_file File.join(elasticsearch_home, 'elasticsearch.yml') do
  owner Helper.user
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
