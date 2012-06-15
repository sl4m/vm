%w(.vbox_version .veewee_version .bash_login .bash_logout .bash_history .bashrc postinstall.sh .profile .sudo_as_admin_successful .zlogin VBoxGuestAdditions_4.1.12.iso).each do |f|
  file "#{ENV['HOME']}/#{f}" do
    action :delete
  end
end
