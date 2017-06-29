#Recherche de l'adresse IP du serveur WEB sur le chef server

webservers=search(:node,'role:WEB',:filter_result => { 'IP' => ['ipaddress']})

if defined?(webservers) && !webservers.empty? then
  webserver=webservers[0]['IP']
else
  webserver='127.0.0.1'
end

#S'assurer que le firewalld est bien ouvert
service 'firewalld' do
  action [:enable, :start]
end

firewall 'default'

#Ouvrir le port 22 ssh
firewall_rule 'ssh' do
  port     22
  command  :allow
end

#Ouvrir le port 8080 pour les test de l'app java
firewall_rule 'http' do
  port     8080
  command  :allow
end

#Redirection du port 8009
firewall_rule 'myapplication' do
  port      8009
  source    "#{webserver}/32"
  direction :in
  command    :allow
end
