%w(libpq-dev postgresql-9.2).each do |p|
  package p
end

# turn on trust authentication
hba_conf = '/etc/postgresql/9.1/main/pg_hba.conf'

bash 'trust authentication' do
  code "sudo sed -i -e \"/local\\\\s\\+all\\\\s\\+all\\\\s\\+peer/c local\\\\tall\\\\tall\\\\ttrust\" #{hba_conf}"
end

bash 'second' do
  code "sudo sed -i -e \"/host\\\\s\\+all\\\\s\\+all\\\\s\\+127.0.0.1\\\\/32\\\\s\\\+md5/c host\\\\tall\\\\tall\\\\t127.0.0.1\\\\/32\\\\ttrust\" #{hba_conf}"
end

bash 'third' do
  code "sudo sed -i -e \"/host\\\\s\\\+all\\\\s\\\+all\\\\s\\\+::1\\\\/128\\\\s\\\+md5/c host\\\\tall\\\\tall\\\\t::1\\\\/128\\\\ttrust\" #{hba_conf}"
end

bash 'create new role' do
  user 'postgres'
  code "createuser -s #{Helper.user}"
  returns [0, 1]
end

bash 'restart postgres with new user and permissions' do
  code 'sudo /etc/init.d/postgresql restart'
end

