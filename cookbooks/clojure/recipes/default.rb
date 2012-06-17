package 'leiningen' do
  action :install
end

cookbook_file "#{ENV['HOME']}/.zsh/leiningen.zsh" do
  owner ENV['USER']
  action :create
end
