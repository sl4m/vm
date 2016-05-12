%w(dnsutils htop ipcalc ncdu procenv vnstat).each do |package|
  apt_package package
end
