# # encoding: utf-8

# Inspec test for recipe apache_conf::apache_configuration

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

control "apache" do
  impact 0.6
  title 'Server: Test the apache configuration with Tomcat'
  desc '
   Test if port, user and files are in place to be able to
   communicate with tomcat server.
  '
  tag 'apache', 'apache-server', "server"
  unless os.windows?
    # This is an example test, replace with your own test.
    describe user('root') do
      it { should exist }
    end
  end

  # This is an example test, replace it with your own test.
  describe port(80) do
    it { should be_listening }
  end

  #Le user apache doit exister
  describe user('apache') do
    it { should exist }
  end

  #Verifier que httpd est enables
  describe service('httpd.service') do
    it { be_running }
  end

  #Verifier que httpd est enables
  describe service('firewalld') do
    it { should be_running }
  end


  #Le port 80 doit etre ouvert
  describe port(80) do
    it { should be_listening }
  end

  #Verifier que le folder apache par default est present
  describe directory("/var/www") do
  	it { should exist }
  end

  describe http('http://localhost/') do
    its('status') { should cmp 200 }
  end
end

control 'Apache_configuration' do
  impact 0.6
  title 'Server: Test the apache configuration with Tomcat'
  desc '
   Test if port, user and files are in place to be able to
   communicate with tomcat server.
  '
  tag 'apache_conf', 'apache configuration', "server"

  describe file('/etc/httpd/conf.modules.d/mod_jk.conf') do
    it { should exist }
  end

  describe file('/etc/httpd/conf/workers.properties') do
    it { should exist }
  end

  describe file('/var/log/modjk/mod_jk.shm') do
    it { should exist }
  end

  describe file('/var/log/modjk/mod_jk.log') do
    it { should exist }
  end

  describe file('/etc/httpd/modules/mod_jk.so') do
    it { should exist }
  end

  describe service('firewalld') do
    it { be_running }
  end

  describe http('http://localhost/sakila/test.jsp') do
    its('status') { should cmp 200 }
  end
end
