#Ouvrir le port 3306 pour le service MySql
execute 'OpenMysql Firewall' do
  command 'firewall-cmd --zone=public --add-port=3306/tcp --permanent'
  action :run
end

#Ouvrir le port 22 pour le service SSH
execute 'OpenMysql Firewall' do
  command 'firewall-cmd --permanent --add-service=ssh'
  action :run
end
