vcprompt_exec = "#{Helper.home('.bin')}/vcprompt"

bash 'install vcprompt' do
  user Helper.user
  group Helper.group
  code <<-EOH
  curl -sL https://github.com/djl/vcprompt/raw/master/bin/vcprompt > #{vcprompt_exec}
  chmod 755 #{vcprompt_exec}
  EOH
  not_if "test -e #{vcprompt_exec}"
end
