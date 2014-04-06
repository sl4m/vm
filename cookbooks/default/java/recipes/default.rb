%w(openjdk-7-jre-headless openjdk-7-jdk).each do |p|
  apt_package p
end
