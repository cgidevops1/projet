# # encoding: utf-8

# Inspec test for recipe testMySQL::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/


# Test port
describe port(3306) do
  it { should be_listening }
end

# Verifie si usager mysql existe
describe user('mysql') do
  it { should exist }
end

# Verifie si group mysql existe
describe group('mysql') do
  it { should exist }
end

# Verifier que mysql est enables
describe service('mysql-foo') do
  it { should be_enabled }
  it { should be_running }
end

# Verifier que httpd est enables
describe service('firewalld') do
  it { should_not be_running }
end

# Verifier que mysql fonctionne avec l'usager mysql
describe processes('mysqld') do
  its('users') { should eq ['mysql'] }
end


# Test une requete MySQL
describe command("echo 'show databases;' | mysql -S /var/run/mysql-foo/mysqld.sock --host=localhost --user=root --password='changeMe'") do
  its('stdout') { should match(/mysql/) }
end

# Test une requete MySQL sur la BD sakila
describe command("echo 'show tables in sakila;' | mysql -S /var/run/mysql-foo/mysqld.sock --host=localhost --user=uSakila --password='pSakila'") do
  its('stdout') { should match(/sakila/) }
end
