#
# Cookbook:: tomcat-config
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe "devops_tomcat::default"

include_recipe "::mysqlconnector"

include_recipe "::firewall"

include_recipe "::deployapp"
