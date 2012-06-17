package 'zsh' do
  action :install
end

directory "#{ENV['HOME']}/.bin" do
  owner ENV['USER']
  action :create
end

remote_file "#{ENV['HOME']}/.bin/vcprompt" do
  owner ENV['USER']
  mode 0755
  action :create
  source 'https://github.com/djl/vcprompt/raw/master/bin/vcprompt'
end

zsh_files_dir = "#{ENV['HOME']}/.zsh"

directory zsh_files_dir do
  owner ENV['USER']
  action :create
end

git "#{zsh_files_dir}/zsh-syntax-highlighting" do
  repository 'https://github.com/zsh-users/zsh-syntax-highlighting.git'
  reference 'master'
  action :sync
end

cookbook_file "#{zsh_files_dir}/zsh-syntax-highlighting.zsh" do
  owner ENV['USER']
  action :create
end

cookbook_file "#{zsh_files_dir}/prompt.zsh" do
  owner ENV['USER']
  action :create
end

cookbook_file "#{ENV['HOME']}/.zshrc" do
  owner ENV['USER']
  action :create
end

bash 'make ZSH the default login shell' do
  code "sudo chsh -s `which zsh` #{ENV['USER']}"
end
