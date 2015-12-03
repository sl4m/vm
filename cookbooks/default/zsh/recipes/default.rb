apt_package 'zsh'

directory Helper.home('.zsh') do
  owner Helper.user
  group Helper.group
end

zsh_files_dir = Helper.home('.zsh')

git "#{zsh_files_dir}/zsh-syntax-highlighting" do
  user Helper.user
  group Helper.group
  repository 'https://github.com/zsh-users/zsh-syntax-highlighting.git'
  reference 'master'
  action :sync
end

cookbook_file Helper.home('.zsh/zsh-syntax-highlighting.zsh') do
  owner Helper.user
  group Helper.group
end

cookbook_file Helper.home('.zsh/prompt.zsh') do
  owner Helper.user
  group Helper.group
end

cookbook_file Helper.home('.zshrc') do
  owner Helper.user
  group Helper.group
end

bash 'make ZSH the default login shell' do
  code "sudo chsh -s `which zsh` #{Helper.user}"
end
