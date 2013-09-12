zsh_file 'ruby_build'

ruby_build_dir = Helper.home('.ruby_build')
user_directory ruby_build_dir

git ruby_build_dir do
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
