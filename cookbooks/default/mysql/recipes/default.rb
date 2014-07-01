%w(libmysqlclient-dev mysql-server mysql-client).each do |p|
  apt_package p
end
