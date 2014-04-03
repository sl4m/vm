zsh_file 'chruby'

chruby_version = '0.3.8'
chruby_url = "https://github.com/postmodern/chruby/archive/v#{chruby_version}.tar.gz"
chruby_tar = Helper.home("v#{chruby_tar}.tar.gz")
chruby_unpacked_path = Helper.home("chruby-#{chruby_version}")

user_remote_file chruby_tar do
  source chruby_url
  mode '0644'
end

user_bash 'unpack chruby' do
  code "tar -xzvf #{chruby_tar} -C #{Helper.home}"
end

user_file chruby_tar do
  action :delete
end

bash 'install chruby' do
  code <<-EOH
  cd #{chruby_unpacked_path}/
  sudo make install
  EOH
end

user_bash 'touch ~/.ruby-version' do
  code 'touch ~/.ruby-version'
end
