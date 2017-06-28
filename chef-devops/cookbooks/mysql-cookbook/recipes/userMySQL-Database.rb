cookbook_file '/tmp/userMySQL.sql' do
  source 'userMySQL.sql'
  owner 'root'
  group 'root'
  mode '0644'
end


bash 'a bash script' do
  not_if { File::exist?("/tmp/CreateUserMySQL")}
  user 'root'
  cwd '/tmp'
  code <<-EOH
    mysql -S /var/run/mysql-foo/mysqld.sock --host=localhost --user=root --password='changeMe' < /tmp/userMySQL.sql
    touch /tmp/CreateUserMySQL
  EOH
end
