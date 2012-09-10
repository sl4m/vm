user_template '.rvmrc' do
  variables :rvm_path => '/usr/local/rvm'
end

user_cookbook_file '.gemrc'

user_cookbook_file '.rspec'

zsh_file 'rvm'

zsh_file 'ruby'
