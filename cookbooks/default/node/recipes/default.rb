apt_sources_list_file 'nodejs.list'

%w(python-software-properties python g++ make nodejs).each do |p|
  package p
end
