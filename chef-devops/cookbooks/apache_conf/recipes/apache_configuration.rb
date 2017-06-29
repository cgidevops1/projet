#
# Cookbook:: apache_conf
# Recipe:: apache_configuration
#
# Copyright:: 2017, The Authors, All Rights Reserved.
# configuration du fichier httpd.conf
template '/etc/httpd/conf.modules.d/mod_jk.conf' do
  source 'mod_jk.conf.erb'
  owner 'root'
  group 'root'
  mode 00644
end

template '/etc/httpd/conf/workers.properties' do
  variables tomcatIP: '192.168.20.24', tomcatPort: '8009'
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

 execute 'disable_selinux_on_boot' do
   command "sed -i '/SELINUX=enforcing/SELINUX=disabled' /etc/sysconfig/selinux"
   action :nothing
 end

 execute "disable_selinux" do
   command "setenforce 0"
   action :run
   notifies :run, "execute[disable_selinux_on_boot]", :before
 end

directory '/var/log/modjk' do
  owner 'apache'
  group 'apache'
  mode 00755
  recursive true
  action :create
end

file '/var/log/modjk/mod_jk.shm' do
  owner 'apache'
  group 'apache'
  mode 00644
  action :create
end

file '/var/log/modjk/mod_jk.log' do
  owner 'apache'
  group 'apache'
  mode 00644
  action :create
end

execute 'set' do
  command 'command'
  action :run
end

service 'httpd' do
  supports :status => true
  action [ :enable, :restart ]
end
