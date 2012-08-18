%w(sqlite3 libsqlite3-dev).each do |p|
  package p do
    action :install
  end
end
