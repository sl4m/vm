terraform_version  = '0.6.15'
terraform_package  = "terraform_#{terraform_version}_linux_amd64"
terraform_url      = "https://releases.hashicorp.com/terraform/#{terraform_version}/#{terraform_package}.zip"
terraform_zip      = Helper.home('terraform.zip')
terraform_home     = Helper.home('.terraform')

remote_file terraform_zip do
  owner Helper.user
  source terraform_url
  mode '0644'
end

directory terraform_home do
  owner Helper.user
  action :delete
  recursive true
end

bash 'unzip terraform' do
  user Helper.user
  group Helper.group
  code "unzip #{terraform_zip} -d #{terraform_home}"
end

file terraform_zip do
  owner Helper.user
  action :delete
end

cookbook_file Helper.home('.zsh/terraform.zsh') do
  owner Helper.user
  group Helper.group
end
