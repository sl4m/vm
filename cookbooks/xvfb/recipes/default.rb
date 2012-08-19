%w(firefox xvfb x11-apps).each do |lib|
  package lib
end

home_directory '.xvfb'

cookbook_file '/etc/init.d/xvfb' do
  mode 0755
end

bash 'initialize init deamon script' do
  code 'sudo update-rc.d xvfb defaults'
end

ENV['DISPLAY'] = Helper.display

bash 'start xvfb' do
  code 'sudo /etc/init.d/xvfb start'
end

firefox_profile_dir = Helper.home('.mozilla/firefox/vagrant')

user_bash 'create a firefox profile' do
  code "firefox -CreateProfile \"#{Helper.user} #{firefox_profile_dir}\""
end

cookbook_file File.join(firefox_profile_dir, 'user.js') do
  owner Helper.user
end

zsh_template 'xvfb' do
  variables :display => Helper.display
end
