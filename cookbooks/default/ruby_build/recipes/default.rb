cookbook_file Helper.home('.zsh/ruby_build.zsh') do
  owner Helper.user
end

ruby_build_dir = Helper.home('.ruby_build')

directory ruby_build_dir do
  owner Helper.user
  group Helper.group
end

git ruby_build_dir do
  user Helper.user
  group Helper.group
  repository 'https://github.com/sstephenson/ruby-build.git'
  reference 'master'
  action :sync
end

bash 'install ruby-build' do
  code <<-EOH
  cd #{ruby_build_dir}
  sudo ./install.sh
  EOH
end
