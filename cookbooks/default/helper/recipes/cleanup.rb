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
  file Helper.home(f) do
    owner Helper.user
    action :delete
  end
end

directory Helper.home('tmp') do
  owner Helper.user
  action :delete
  recursive true
end
