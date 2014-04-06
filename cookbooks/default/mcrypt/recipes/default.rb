%w(mcrypt libmcrypt-dev).each do |p|
  apt_package p
end
