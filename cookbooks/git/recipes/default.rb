package 'git-core' do
  action :install
end

cookbook_file "#{ENV['HOME']}/.gitconfig" do
  owner ENV['USER']
  action :create
end
