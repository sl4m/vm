package 'vim-nox' do
  action :install
end

package 'vim-runtime' do
  action :install
end

cookbook_file "#{ENV['HOME']}/.vimrc" do
  owner ENV['USER']
  action :create
end

vim_dir = "#{ENV['HOME']}/.vim"

remote_directory vim_dir do
  overwrite true
  purge true
  owner ENV['USER']
  recursive true
  action :create
end

bundle_dir = "#{vim_dir}/bundle"

directory bundle_dir do
  owner ENV['USER']
  action :create
end

git "#{bundle_dir}/command-t" do
  repository 'https://github.com/wincent/Command-T.git'
  reference 'master'
  action :sync
end

bash 'build command-t' do
  code <<-EOH
  cd #{bundle_dir}/command-t/ruby/command-t
  ruby extconf.rb
  make clean
  make
  EOH
end

git "#{bundle_dir}/vim-fugitive" do
  repository 'https://github.com/tpope/vim-fugitive.git'
  reference 'master'
  action :sync
end

git "#{bundle_dir}/vim-ruby" do
  repository 'https://github.com/vim-ruby/vim-ruby.git'
  reference 'master'
  action :sync
end

git "#{bundle_dir}/vim-ruby" do
  repository 'https://github.com/vim-ruby/vim-ruby.git'
  reference 'master'
  action :sync
end

git "#{bundle_dir}/nerdtree" do
  repository 'https://github.com/scrooloose/nerdtree.git'
  reference 'master'
  action :sync
end
