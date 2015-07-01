cookbook_file Helper.home('.gemrc') do
  owner Helper.user
end

cookbook_file Helper.home('.zsh/ruby.zsh') do
  owner Helper.user
end
