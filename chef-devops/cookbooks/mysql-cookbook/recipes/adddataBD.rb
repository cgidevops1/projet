cookbook_file '/tmp/tables.sql' do
  source 'table.sql'
  owner 'root'
  group 'root'
  mode '0644'
end

cookbook_file '/tmp/data.sql' do
  source 'data.sql'
  owner 'root'
  group 'root'
  mode '0644'
end


bash 'a bash script' do
  not_if { File::exist?("/tmp/exported-data")}
  user 'root'
  cwd '/tmp'
  code <<-EOH
    mysql -S /var/run/mysql-foo/mysqld.sock --host=localhost --user=root --password='changeMe' < /tmp/tables.sql
    mysql -S /var/run/mysql-foo/mysqld.sock --host=localhost --user=root --password='changeMe' < /tmp/data.sql
    touch /tmp/exported-data
  EOH
end
