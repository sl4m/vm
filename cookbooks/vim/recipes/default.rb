vim_dir = Helper.home('.vim')
vim_dotfiles_dir = Helper.home('.vim_dotfiles')

package 'vim-nox'

git vim_dotfiles_dir do
  repository 'https://github.com/sl4m/vim_dotfiles.git'
  reference 'master'
  action :checkout
  enable_submodules true
end

link "#{vim_dir}/.vimrc" do
  Helper.user
  to "#{vim_dotfiles_dir}/vimrc"
  not_if "test -e #{vim_dir}/.vimrc"
end

link "#{vim_dir}/.vim" do
  Helper.user
  to "#{vim_dotfiles_dir}/vim"
  not_if "test -e #{vim_dir}/.vim"
end

bash 'build command-t' do
  code <<-EOH
  cd #{vim_dotfiles_dir}/vim/bundle/command-t/ruby/command-t
  rvm use system
  ruby extconf.rb
  make clean
  make
  EOH
end
