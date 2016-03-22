dtrace_dir = Helper.home('.dtrace')

directory dtrace_dir do
  owner Helper.user
  group Helper.group
end

git dtrace_dir do
  user Helper.user
  group Helper.group
  repository 'https://github.com/dtrace4linux/linux.git'
  reference 'master'
  action :checkout
end

bash "install dtrace" do
  user Helper.user
  group Helper.group
  code <<-EOH
  cd #{dtrace_dir}
  sudo tools/get-deps.pl
  make all
  sudo make install
  sudo make load
  EOH
end
