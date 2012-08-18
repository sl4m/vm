%w(libmysqlclient-dev mysql-server mysql-client libmysql-ruby libmysqlclient-dev).each do |p|
  package p do
    action :install
  end
end
