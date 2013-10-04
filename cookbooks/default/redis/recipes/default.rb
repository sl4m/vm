package 'redis-server' do
  version '2:2.2.12-1build1'
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
