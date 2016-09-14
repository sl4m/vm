cookbook_file '/etc/apt/sources.list.d/elasticsearch.list'

bash 'apt key/apt-get update' do
  code Helper.apt_key('https://packages.elastic.co/GPG-KEY-elasticsearch')
end

apt_package 'elasticsearch'
