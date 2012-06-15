shared_code_dir = "#{ENV['SHARED']}/code"
user_code_dir = "#{ENV['HOME']}/code"

directory shared_code_dir do
  owner ENV['USER']
  action :create
end

bash 'link the shared code directory to the users code directory' do
  user ENV['USER']
  code "ln -s #{shared_code_dir} #{user_code_dir}"
  not_if "ls -l #{user_code_dir}"
end

bash 'clone registration repo' do
  user ENV['USER']
  code "git clone git@github.com:sittercity/registration.git #{user_code_dir}/registration"
  not_if "test -d #{ENV['HOME']}/code/registration"
end
