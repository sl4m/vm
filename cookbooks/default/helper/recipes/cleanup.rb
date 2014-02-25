%w(
  .vbox_version
  .bash_login
  .bash_logout
  .bash_history
  .bashrc
  postinstall.sh
  .profile
  .sudo_as_admin_successful
  .zlogin
).each do |f|
  home_file f do
    action :delete
  end
end

home_directory 'tmp' do
  action :delete
  recursive true
end
