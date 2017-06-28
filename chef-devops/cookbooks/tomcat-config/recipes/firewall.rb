#S'assurer que le firewalld est bien ouvert
service 'firewalld' do
  #supports status: true
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
  source    '192.168.20.25/32'
  direction :in
  #interface 'eth0'
  command    :allow
end
