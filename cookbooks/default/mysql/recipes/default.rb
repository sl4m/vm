%w(libmysqlclient-dev mysql-server mysql-client libmysql-ruby).each do |p|
  apt_package p
end
