# # encoding: utf-8

# Inspec test for recipe modjk::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

control "modjk" do

  impact 0.6
  title "Test to compiling modJK"
  desc '
   Will check if the compilating share object is correctly created.
  '
  tag "apache", "tomcat", "modjk"

  describe package('httpd-devel') do
    it { should be_installed }
  end

  describe package('gcc') do
    it { should be_installed }
  end

  describe package('gcc-c++') do
    it { should be_installed }
  end

  describe package('make') do
    it { should be_installed }
  end

  describe package('libtool') do
    it { should be_installed }
  end

  describe file('/usr/bin/apxs') do
    it { should be_executable }
  end

  # describe bash('libtool') do
  #   it { should exist }
  # end
  #
  # describe bash('find / -name tomcat-connector-1.2.42-src.tar.gz') do
  #   its('stdout') { should match "*tomcat-connector-1.2.42-src.tar.gz" }
  # end

  describe file('/etc/httpd/modules/mod_jk.so') do
    it { should exist }
  end

  # describe file('/etc/httpd/conf.d/jk.conf') do
  #   it { should exist }
  # end
  #
  # describe file('/etc/httpd/conf.d/workers.properties') do
  #   it { should exist }
  # end
  #
  # describe file('/var/log/httpd/mod_jk.shm') do
  #   it { should exist }
  # end
  #
  # describe file('/var/log/httpd/mod_jk.log') do
  #   it { should exist }
  # end
end
