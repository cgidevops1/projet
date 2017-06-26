#
# Cookbook:: devops_tomcat
# Recipe:: Tomcat
#
# Copyright:: 2017, The Authors, All Rights Reserved.
#installation de java
package 'java-1.8.0-openjdk.x86_64'do
end

# sudo groupadd tomcat
group 'tomcat'

#useradd -M -s /bin/nologin -g tomcat -d /opt/tomcat tomcat
user 'tomcat' do
  comment 'tomcat user'
  manage_home false
  shell '/bin/nologin'
  group 'tomcat'
end

#wget http://www-us.apache.org/dist/tomcat/tomcat-8/v8.5.15/bin/apache-tomcat-8.5.15.tar.gz
remote_file 'apache-tomcat-8.5.15.tar.gz' do
  source 'http://www-us.apache.org/dist/tomcat/tomcat-8/v8.5.15/bin/apache-tomcat-8.5.15.tar.gz'
end
# create directory /opt/tomcat
directory '/opt/tomcat' do
  action :create
  group 'tomcat'
end

#unzip du package de tomcat avec tar dans le dossier /opt/tomcat
execute 'tar -zxvf apache-tomcat-8.5.15.tar.gz -C /opt/tomcat --strip-components=1'
#chanee le groupe  pour TOMCAT dans /opt/tomcat
execute 'chgrp -R tomcat /opt/tomcat'
#ajout du mode read dans dossier conf
execute 'chmod -R g+r conf' do
  cwd '/opt/tomcat'
end
#ajout de EXECUTE dans /opt/tomcat/conf
execute 'chmod g+x /opt/tomcat/conf'
# se place dans le dossier /opt/tomcat et change le ownder pour tomcat
execute 'chown -R tomcat logs/ temp/ webapps/ work/' do
  cwd '/opt/tomcat'
end
# création du service pour tomcat
template '/etc/systemd/system/tomcat.service'do
  source 'tomcat_service.erb'
end
#restart des services
execute 'systemctl daemon-reload'
# start le service tomcat
service 'tomcat' do
    action [ :start, :enable ]
end
