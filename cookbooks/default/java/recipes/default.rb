%w(openjdk-8-jre-headless openjdk-8-jdk).each do |p|
  apt_package p
end
