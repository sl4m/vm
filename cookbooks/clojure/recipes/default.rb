lein_dir = File.join(ENV['HOME'], '.lein')
lein_bin_dir = File.join(lein_dir, 'bin')
lein_self_install_dir = File.join(lein_dir, 'self-installs')
lein_bin = File.join(lein_dir, 'lein')

directory lein_bin_dir do
  action :create
  recursive true
end

remote_file lein_bin do
  owner ENV['USER']
  mode 0755
  source 'https://raw.github.com/technomancy/leiningen/preview/bin/lein'
end

directory lein_self_install_dir do
  action :delete
  recursive true
end

bash 'install leiningen' do
  user ENV['USER']
  code "HTTP_CLIENT=\"wget --no-check-certificate -O\" #{lein_bin} self-install"
end

cookbook_file "#{ENV['HOME']}/.zsh/leiningen.zsh" do
  owner ENV['USER']
  action :create
end
