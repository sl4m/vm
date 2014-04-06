apt_sources_list_file 'nodejs.list'

%w(python g++ make).each do |p|
  apt_package p
end

apt_package 'nodejs' do
  action :upgrade
end
