redis_package = 'redis-2.8.8'
redis_url = "http://download.redis.io/releases/#{redis_package}.tar.gz"
redis_tar = Helper.home('redis.tar.gz')
redis_home = Helper.home('.redis')
redis_unpacked_path = Helper.home(redis_package)

user_remote_file redis_tar do
  source redis_url
  mode '0644'
end

user_directory redis_home do
  action :delete
  recursive true
end

user_bash 'unpack redis' do
  code "tar -xzvf #{redis_tar} -C #{Helper.home}"
end

user_bash 'move redis' do
  code "mv #{redis_unpacked_path} #{redis_home}"
end

user_file redis_tar do
  action :delete
end

user_bash 'install redis' do
  code <<-EOH
  cd #{redis_home}/
  make
  EOH
end

user 'redis' do
  home '/var/lib/redis'
  system true
  group 'admin'
end

cookbook_file '/etc/redis.conf' do
  owner 'redis'
end

cookbook_file '/etc/init.d/redis-server' do
  owner 'redis'
  mode 0755
end

directory '/var/lib/redis' do
  owner 'redis'
end

directory '/var/log/redis' do
  owner 'redis'
end

bash 'initialize init daemon script' do
  code 'sudo update-rc.d redis-server defaults'
end

bash 'start redis' do
  user 'redis'
  code 'sudo /etc/init.d/redis-server start'
end
