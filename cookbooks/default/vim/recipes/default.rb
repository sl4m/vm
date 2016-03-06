vimrc_dir        = Helper.home('.vimrc')
vim_dir          = Helper.home('.vim')
vim_dotfiles_dir = Helper.home('.vim_dotfiles')

directory vim_dotfiles_dir do
  owner Helper.user
  group Helper.group
end

apt_package 'vim-nox'

git vim_dotfiles_dir do
  user Helper.user
  group Helper.group
  repository 'https://github.com/sl4m/vim-dotfiles.git'
  reference 'master'
  action :checkout
end

bash "link #{vimrc_dir}" do
  user Helper.user
  group Helper.group
  code <<-EOH
  ln -s #{vim_dotfiles_dir}/vimrc #{vimrc_dir}
  EOH
  not_if "test -e #{vimrc_dir}"
end

bash "link #{vim_dir}" do
  user Helper.user
  group Helper.group
  code <<-EOH
  ln -s #{vim_dotfiles_dir}/vim #{vim_dir}
  EOH
  not_if "test -e #{vim_dir}"
end
