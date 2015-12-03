lein_dir              = Helper.home('.lein')
lein_bin_dir          = File.join(lein_dir, 'bin')
lein_self_install_dir = File.join(lein_dir, 'self-installs')
lein_bin              = File.join(lein_dir, 'bin', 'lein')

directory lein_bin_dir do
  owner Helper.user
  group Helper.group
  recursive true
end

file lein_bin do
  owner Helper.user
  action :delete
end

directory lein_self_install_dir do
  owner Helper.user
  action :delete
  recursive true
end

directory lein_self_install_dir do
  owner Helper.user
  group Helper.group
end

remote_file lein_bin do
  owner Helper.user
  mode 0755
  source 'https://raw.github.com/technomancy/leiningen/stable/bin/lein'
end

bash 'install leiningen' do
  user Helper.user
  group Helper.group
  code "#{lein_bin} self-install"
end

cookbook_file Helper.home('.zsh/leiningen.zsh') do
  owner Helper.user
  group Helper.group
end
