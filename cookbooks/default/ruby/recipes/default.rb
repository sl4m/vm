cookbook_file Helper.home('.gemrc') do
  owner Helper.user
  group Helper.group
end

cookbook_file Helper.home('.zsh/ruby.zsh') do
  owner Helper.user
  group Helper.group
end
