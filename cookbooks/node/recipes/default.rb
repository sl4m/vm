%w(nodejs npm).each do |p|
  package p do
    action :install
  end
end
