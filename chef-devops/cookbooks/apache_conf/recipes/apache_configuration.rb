#
# Cookbook:: apache_conf
# Recipe:: apache_configuration
#
# Copyright:: 2017, The Authors, All Rights Reserved.
# configuration du fichier httpd.conf


appservers=search(:node,'role:APP',:filter_result => { 'IP' => ['ipaddress']})

if defined?(appservers) && !appservers.empty? then
  appserver=appservers[0]['IP']
else
  appserver='127.0.0.1'
end

template '/etc/httpd/conf.modules.d/mod_jk.conf' do
  source 'mod_jk.conf.erb'
  owner 'root'
  group 'root'
  mode 00644
end

template '/etc/httpd/conf/workers.properties' do
  variables tomcatIP: appserver, tomcatPort: '8009'
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

service 'httpd' do
  supports :status => true
  action [ :enable, :restart ]
end
