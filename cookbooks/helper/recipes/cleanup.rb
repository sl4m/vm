%w(.vbox_version .veewee_version .bash_login .bash_logout .bash_history .bashrc postinstall.sh .profile .sudo_as_admin_successful .zlogin VBoxGuestAdditions_4.1.18.iso).each do |f|
  home_file f do
    action :delete
  end
end

home_directory 'tmp' do
  action :delete
end
