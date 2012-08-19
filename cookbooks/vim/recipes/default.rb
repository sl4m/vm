package 'vim-nox'

user_cookbook_file '.vimrc'

vim_dir = Helper.home('.vim')

user_remote_directory vim_dir do
  overwrite true
  purge true
  recursive true
end

bundle_dir = "#{vim_dir}/bundle"

user_directory bundle_dir

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

git "#{bundle_dir}/vim-clojure" do
  repository 'https://github.com/vim-scripts/VimClojure.git'
  reference 'master'
  action :sync
end

git "#{bundle_dir}/vim-coffee-script" do
  repository 'https://github.com/kchmck/vim-coffee-script.git'
  reference 'master'
  action :sync
end

git "#{bundle_dir}/mustache.vim" do
  repository 'https://github.com/juvenn/mustache.vim.git'
  reference 'master'
  action :sync
end
