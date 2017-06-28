#
# Cookbook:: apache_conf
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
include_recipe 'apache::default'
include_recipe 'modjk::default'
include_recipe 'apache_conf::apache_configuration'
