#
# Cookbook:: mysql-cookbook
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# mysql -S /var/run/mysql-foo/mysqld.sock --host=localhost --user=root --password='changeMe'
#sudo yum list installed | grep "^mysql"

mysql_service 'foo' do
  port '3306'
  version '5.6'
  initial_root_password 'changeMe'
  action [:create, :start]
end

include_recipe "::adddataBD"


#include_recipe "mysqlfirewall"
