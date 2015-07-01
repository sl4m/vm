cookbook_file '/etc/apt/sources.list.d/basho.list'

bash 'apt key/apt-get update' do
  code Helper.apt_key('http://apt.basho.com/gpg/basho.apt.key')
end

apt_package 'riak'
