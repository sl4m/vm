package 'tmux' do
  version '1.6-1ubuntu1'
  action :install
end

cookbook_file "#{ENV['HOME']}/.tmux.conf" do
  owner ENV['USER']
  action :create
end
