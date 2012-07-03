package 'python-software-properties' do
  action :install
end

bash 'install node.js' do
  code <<-EOH
  sudo apt-add-repository ppa:chris-lea/node.js
  sudo apt-get update
  EOH
end

%w(nodejs npm).each do |p|
  package p do
    action :install
  end
end
