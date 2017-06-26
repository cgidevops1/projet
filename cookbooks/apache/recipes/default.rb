#
# Cookbook:: apache
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Install apache
package ['httpd','telnet'] do
  action :install
end

# Apache start the service.
service "httpd" do
  action [:restart]
end

service "firewalld" do
  action [:disable,:stop]
end
