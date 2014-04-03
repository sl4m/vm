home_directory '.bin'

vcprompt_exec = "#{Helper.home('.bin')}/vcprompt"

user_bash 'install vcprompt' do
  code <<-EOH
  curl -sL https://github.com/djl/vcprompt/raw/master/bin/vcprompt > #{vcprompt_exec}
  chmod 755 #{vcprompt_exec}
  EOH
  not_if "test -e #{vcprompt_exec}"
end
