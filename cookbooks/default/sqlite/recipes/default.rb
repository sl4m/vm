%w(sqlite3 libsqlite3-dev).each do |p|
  apt_package p
end
