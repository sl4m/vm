package 'vim-common' do
  action :install
end

package 'vim-runtime' do
  action :install
end

package 'vim-nox' do
  action :install
end

cookbook_file "#{ENV['HOME']}/.vimrc" do
  action :create
end

remote_directory "#{ENV['HOME']}/.vim" do
  overwrite true
  purge true
  owner ENV['USER']
  recursive true
  action :create
end

# clone git modules

#bash "build command-t" do
#  user ENV['USER']
#  code <<-EOH
#  cd #{vim_dotfiles_dir}/vim/bundle/command-t/ruby/command-t
#  ruby extconf.rb
#  make clean
#  make
#  EOH
#end
