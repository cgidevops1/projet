# Install MySQL
mysql_service 'foo' do
  port '3306'
  version '5.6'
  initial_root_password 'changeMe'
  action [:create, :start]
end
