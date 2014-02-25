%w(python-software-properties python g++ make).each do |p|
  package p
end

bash 'adds chris-lea/node.js repository' do
  Helper.user
  code <<-EOH
  sudo add-apt-repository ppa:chris-lea/node.js
  sudo apt-get update
  EOH
end

package 'nodejs'
