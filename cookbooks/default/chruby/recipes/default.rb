zsh_file 'chruby'

chruby_version = '0.3.8'

bash 'install chruby' do
  code <<-EOH
  wget -O chruby-#{chruby_version}.tar.gz https://github.com/postmodern/chruby/archive/v#{chruby_version}.tar.gz
  tar -xzvf chruby-#{chruby_version}.tar.gz
  cd chruby-#{chruby_version}/
  sudo make install
  EOH
end

bash 'touch ~/.ruby-version' do
  code 'touch ~/.ruby-version'
end
