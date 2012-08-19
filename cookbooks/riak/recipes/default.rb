package 'libssl0.9.8'

riak_package = 'riak_1.1.4-1_amd64.deb'
riak_url = "http://downloads.basho.com/riak/CURRENT/#{riak_package}"
riak_deb = Helper.home(riak_package)

user_remote_file riak_deb do
  source riak_url
  mode '0644'
end

bash 'install riak' do
  code "sudo dpkg -i #{riak_deb}"
end

user_file riak_deb do
  action :delete
end
