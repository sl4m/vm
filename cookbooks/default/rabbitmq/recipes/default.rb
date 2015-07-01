cookbook_file '/etc/apt/sources.list.d/rabbitmq.list'

bash 'apt key/apt-get update' do
  code Helper.apt_key('http://www.rabbitmq.com/rabbitmq-signing-key-public.asc')
end

apt_package 'rabbitmq-server'
