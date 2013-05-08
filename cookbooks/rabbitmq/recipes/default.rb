bash 'adds raring repositories to /etc/apt/sources.list' do
  Helper.user
  version = 'raring'
  sources_list = '/etc/apt/sources.list'
  repositories = <<-EOH
  deb http://us.archive.ubuntu.com/ubuntu/ #{version} main restricted
  deb-src http://us.archive.ubuntu.com/ubuntu/ #{version} main restricted
  EOH

  code <<-EOH
  echo '#{repositories}' | sudo tee -a #{sources_list}
  sudo apt-get update
  EOH

  not_if "cat #{sources_list} | grep #{version}"
end

package 'rabbitmq-server'
