apt_package 'python-software-properties'

bash 'sudo apt-get update' do
  code 'sudo apt-get update'
end

class ::Helper
  def self.home(path='')
    File.join("/home/#{user}", path)
  end

  def self.user
    'vagrant'
  end

  def self.group
    'vagrant'
  end

  def self.display
    ':99.0'
  end

  def self.apt_key(trusted_key_url)
    <<-EOH
    wget --quiet -O - '#{trusted_key_url}' | sudo apt-key add -
    sudo apt-get update
    EOH
  end
end

ENV['HOME'] = Helper.home

directory Helper.home('.bin') do
  owner Helper.user
  group Helper.group
end
