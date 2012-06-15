package 'redis-server' do
  action :install
  version '2:2.2.12-1build1'
end

cookbook_file '/etc/redis.conf' do
  action :create_if_missing
end

user 'redis' do
  action :create
  home '/var/lib/redis'
  system true
  group 'admin'
end

cookbook_file '/etc/init.d/redis-server' do
  owner 'redis'
  mode 0755
  action :create_if_missing
end

directory '/var/lib/redis' do
  group 'redis'
  owner 'redis'
  action :create
end

directory '/var/log/redis' do
  group 'redis'
  owner 'redis'
  action :create
end

bash 'initialize init script' do
  code 'sudo update-rc.d redis-server defaults'
end

bash 'start redis' do
  user 'redis'
  code 'sudo /etc/init.d/redis-server start'
end
