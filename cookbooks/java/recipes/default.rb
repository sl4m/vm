%w(openjdk-7-jre-headless openjdk-7-jdk).each do |p|
  package p do
    action :install
  end
end
