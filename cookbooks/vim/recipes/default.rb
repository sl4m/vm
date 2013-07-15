vimrc_dir = Helper.home('.vimrc')
vim_dir = Helper.home('.vim')
vim_dotfiles_dir = Helper.home('.vim_dotfiles')

package 'vim-nox'

git vim_dotfiles_dir do
  repository 'https://github.com/sl4m/vim_dotfiles.git'
  reference 'master'
  action :checkout
  enable_submodules true
end

bash "link #{vimrc_dir}" do
  code <<-EOH
  ln -s #{vim_dotfiles_dir}/vimrc #{vimrc_dir}
  EOH
  not_if "test -e #{vimrc_dir}"
end

bash "link #{vim_dir}" do
  code <<-EOH
  ln -s #{vim_dotfiles_dir}/vim #{vim_dir}
  EOH
  not_if "test -e #{vim_dir}"
end

bash 'build command-t' do
  code <<-EOH
  cd #{vim_dotfiles_dir}/vim/bundle/command-t/ruby/command-t
  ruby extconf.rb
  make clean
  make
  EOH
end
