%w(firefox xvfb x11-apps).each do |lib|
  package lib do
    action :install
  end
end

directory "#{ENV['HOME']}/.xvfb" do
  owner ENV['USER']
  action :create
end

cookbook_file '/etc/init.d/xvfb' do
  mode 0755
  action :create
end

bash 'initialize init script' do
  code 'sudo update-rc.d xvfb defaults'
end

bash 'start xvfb' do
  code 'sudo /etc/init.d/xvfb start'
end

firefox_profile_dir = File.join(ENV['HOME'], '.mozilla/firefox/vagrant')

bash 'create a firefox profile' do
  user ENV['USER']
  code "firefox -CreateProfile \"#{ENV['USER']} #{firefox_profile_dir}\""
  #not_if "test -d #{firefox_profile_dir}"
end

cookbook_file File.join(firefox_profile_dir, 'user.js') do
  owner ENV['USER']
  action :create
end

template "#{ENV['HOME']}/.zsh/xvfb.zsh" do
  owner ENV['USER']
  action :create
  variables :display => ENV['DISPLAY']
end
