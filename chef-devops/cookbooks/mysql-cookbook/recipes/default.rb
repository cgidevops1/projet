#
# Cookbook:: mysql-cookbook
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# mysql -S /var/run/mysql-foo/mysqld.sock --host=localhost --user=root --password='changeMe'
#sudo yum list installed | grep "^mysql"


include_recipe '::installMySQL'
include_recipe '::adddataBD'
#include_recipe '::mysqlfirewall'
include_recipe '::userMySQL-Database'
