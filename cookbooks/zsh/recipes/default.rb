package 'zsh' do
  version '4.3.17-1ubuntu1'
  action :install
end

directory "#{ENV['HOME']}/.bin" do
  owner ENV['USER']
  action :create
end

directory "#{ENV['HOME']}/.zsh" do
  owner ENV['USER']
  action :create
end

vcprompt_exec = "#{ENV['HOME']}/.bin/vcprompt"
bash 'install vcprompt' do
  user ENV['USER']
  code <<-EOH
  curl -sL https://github.com/djl/vcprompt/raw/master/bin/vcprompt > #{vcprompt_exec}
  chmod 755 #{vcprompt_exec}
  EOH
end

git "#{ENV['HOME']}/zsh-syntax-highlighting" do
  repository 'https://github.com/zsh-users/zsh-syntax-highlighting.git'
  reference 'master'
  action :sync
end

directory "#{ENV['HOME']}/.zsh/zsh-syntax-highlighting" do
  action :create
end

bash 'copy zsh-syntax-highlighting' do
  code "cp -r #{ENV['HOME']}/zsh-syntax-highlighting/* #{ENV['HOME']}/.zsh/zsh-syntax-highlighting"
end

directory "#{ENV['HOME']}/zsh-syntax-highlighting" do
  recursive true
  action :delete
end

template "#{ENV['HOME']}/.zshrc" do
  owner ENV['USER']
  action :create
  variables :display => ENV['DISPLAY']
end

bash 'make ZSH the default login shell' do
  code "sudo chsh -s `which zsh` #{ENV['USER']}"
end
