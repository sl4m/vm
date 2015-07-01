cookbook_file Helper.home('.zsh/chruby.zsh') do
  owner Helper.user
end

chruby_version       = '0.3.9'
chruby_url           = "https://github.com/postmodern/chruby/archive/v#{chruby_version}.tar.gz"
chruby_tar           = Helper.home("v#{chruby_tar}.tar.gz")
chruby_unpacked_path = Helper.home("chruby-#{chruby_version}")

remote_file chruby_tar do
  owner Helper.user
  source chruby_url
  mode '0644'
end

bash 'unpack chruby' do
  user Helper.user
  code "tar -xzvf #{chruby_tar} -C #{Helper.home}"
end

file chruby_tar do
  owner Helper.user
  action :delete
end

bash 'install chruby' do
  code <<-EOH
  cd #{chruby_unpacked_path}/
  sudo make install
  EOH
end

bash 'touch ~/.ruby-version' do
  user Helper.user
  code 'touch ~/.ruby-version'
end
