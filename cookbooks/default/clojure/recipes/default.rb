lein_dir = Helper.home('.lein')
lein_bin_dir = File.join(lein_dir, 'bin')
lein_self_install_dir = File.join(lein_dir, 'self-installs')
lein_bin = File.join(lein_dir, 'bin', 'lein')

user_directory lein_bin_dir do
  recursive true
end

user_file lein_bin do
  action :delete
end

user_directory lein_self_install_dir do
  action :delete
  recursive true
end

user_directory lein_self_install_dir

user_remote_file lein_bin do
  mode 0755
  source 'https://raw.github.com/technomancy/leiningen/stable/bin/lein'
end

user_bash 'install leiningen' do
  code "#{lein_bin} self-install"
end

zsh_file 'leiningen'
