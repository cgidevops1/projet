# # encoding: utf-8

# Inspec test for recipe devops_tomcat::Tomcat

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

control 'tomcat-control' do
  impact 0.8
  title 'Server: Configure the service port'
  desc '
   Always specify which port the SSH server should listen to.
   Prevent unexpected settings.
  '
  tag 'tomcat','tomcat-service','tomcat-server'
  ref 'NSA-RH6-STIG - Section 3.5.2.1', url: 'https://www.nsa.gov/ia/_files/os/redhat/rhel5-guide-i731.pdf'

  unless os.windows?
    # This is an example test, replace with your own test.
    describe user('root'), :skip do
      it { should exist }
    end
  end

  describe package("java-1.8.0-openjdk") do
   it { should be_installed }
  end

  describe group('tomcat') do
   it { should exist }
  end

  describe user('tomcat') do
   it { should exist }
   its('group') { should eq 'tomcat' }
   its('shell') { should eq '/bin/nologin' }
  end

  describe directory('/opt/tomcat') do
    it { should be_owned_by "root" }
    it { should be_grouped_into 'tomcat' }
    its('mode') { should cmp '0755' }
  end

  describe service("tomcat.service") do
   it { should be_enabled }
   it { should be_running }
  end

  # This is an example test, replace it with your own test.
  describe port(8080), :skip do
    it { should be_listening }
  end
end
