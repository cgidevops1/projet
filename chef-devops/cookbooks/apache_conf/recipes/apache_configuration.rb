#
# Cookbook:: apache_conf
# Recipe:: apache_configuration
#
# Copyright:: 2017, The Authors, All Rights Reserved.
# configuration du fichier httpd.conf
template '/etc/httpd/conf.d/mod_jk.conf' do
  source 'mod_jk.conf.erb'
  owner 'root'
  group 'root'
  mode 00644
end

template '/etc/httpd/conf.d/workers.properties' do
  source 'workers.properties.erb'
  owner 'root'
  group 'root'
  mode 00644
end

#start du service firewall
service 'firewalld' do
    action [ :enable, :start ]
end
 #configuration du firewall pourle port 80
 execute 'firewall-cmd --zone=public --permanent --add-port=80/tcp' do
   notifies :run,'execute[firewall-cmd --reload]', :delayed
 end
 execute 'firewall-cmd --reload' do
   action :nothing
 end

file '/var/log/httpd/mod_jk.shm' do
  owner 'root'
  group 'root'
  mode 00755
  action :create
end

file '/var/log/httpd/mod_jk.log' do
  owner 'root'
  group 'root'
  mode 00755
  action :create
end
