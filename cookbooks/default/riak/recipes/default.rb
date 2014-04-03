apt_sources_list_file 'basho.list'

bash 'apt key/apt-get update' do
  code Helper.apt_key('http://apt.basho.com/gpg/basho.apt.key')
end

package 'riak'
