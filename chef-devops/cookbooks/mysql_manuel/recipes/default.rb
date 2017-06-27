#
# Cookbook:: mysql_manuel
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

init_script = ::File.join(Chef::Config[:file_cache_path], 'init_mysql.sql')
root_password = 'qwerty'

# Ajout du repository mysql.
template '/etc/pki/rpm-gpg/RPM-GPG-KEY-mysql' do
  source 'RPM-GPG-KEY-mysql.erb'
  user 'root'
  group 'root'
  mode '0644'
end

template '/etc/yum.repos.d/mysql-community.repo' do
  source 'mysql-community.repo.erb'
  user 'root'
  group 'root'
  mode '0644'
end

template '/etc/yum.repos.d/mysql-community-source.repo' do
  source 'mysql-community-source.repo.erb'
  user 'root'
  group 'root'
  mode '0644'
end

# Changement du mot de passe root sur le service mysql.
template init_script do
  source 'init_mysql.sql.erb'
  user 'root'
  group 'root'
  mode '0644'
  #  variables(:dbpassword => root_password)
   variables(:dbpassword => root_password)
end

 execute 'mysql_init' do
  command "mysqld --initialize --user=mysql --init-file=#{init_script}"
  action :nothing
end


# Installation du package mysql-server.
package 'mysql-server' do
  action :install
  notifies :run, 'execute[mysql_init]', :immediate
end

# Ajout à la sequence de démarrage automatique et démarre le service mysqld.
service 'mysqld' do
  action [:start, :enable]
end
