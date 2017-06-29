dbservers=search(:node,'role:DB',:filter_result => { 'IP' => ['ipaddress']})

if defined?(dbservers) && !dbservers.empty? then
  dbserver=dbservers[0]['IP']
else
  dbserver='127.0.0.1'
end




directory '/tmp/sakilatmp' do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

#Extraire l'application jsp (sakila) sur tomcat
cookbook_file '/tmp/sakilatmp/sakila.war' do
  source 'sakila.war'
  owner 'tomcat'
  group 'tomcat'
  mode '0644'
  action :create
end


execute 'expand_service' do
  cwd "/tmp/sakilatmp/"
  command "jar xf /tmp/sakilatmp/sakila.war"
end

file '/tmp/sakilatmp/sakila.war' do
  action :delete
end


#Extraire le template context.xml dans l'application deployer dans tomcat
template '/tmp/sakilatmp/META-INF/context.xml' do
  source 'context.xml.erb'
  variables({:appuser => 'uSakila',:apppassword => 'pSakila', :appmysqladd => dbserver,:appbd => 'sakila'})
  owner 'tomcat'
  group 'tomcat'
  mode '0644'
end

execute 'deploy war' do
  cwd "/tmp/sakilatmp/"
  command "jar cf /opt/tomcat/webapps/sakila.war *"
end

service 'tomcat' do
  action :restart
end
