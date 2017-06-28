#Extraire le connector Mysql
cookbook_file '/opt/tomcat/lib/mysql-connector-java-5.1.42-bin.jar' do
  source 'mysql-connector-java-5.1.42-bin.jar'
  owner 'root'
  group 'root'
  mode '0644'
end

#Extraire le template server.xml de tomcat
template '/opt/tomcat/conf/server.xml' do
  source 'server.xml.erb'
  variables(:worker => 'worker1')
  owner 'root'
  group 'root'
  mode '0644'
end
