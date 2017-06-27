#
# Cookbook:: modjk
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Installation des prerequis pour modjk.
package ['httpd-devel', 'gcc','gcc-c++', 'make', 'libtool'] do
  action :install
end

# Telecharge la source modjk.
remote_file "#{Chef::Config[:file_cache_path]}/tomcat-connectors-1.2.42-src.tar.gz" do
  source "http://mirror.csclub.uwaterloo.ca/apache/tomcat/tomcat-connectors/jk/tomcat-connectors-1.2.42-src.tar.gz"
  action :create_if_missing
end

# Extraction et compilation du modjk.
bash "compile_modjk" do
  cwd Chef::Config[:file_cache_path]
  environment 'PKG_CONFIG_PATH' => "/usr/lib64/pkgconfig:/usr/share/pkgconfig"
  code <<-EOH
    tar zxf tomcat-connectors-1.2.42-src.tar.gz
    cd tomcat-connectors-1.2.42-src/native
    ./configure --with-apxs=/usr/bin/apxs
    make && make install
  EOH
  creates "/usr/lib64/httpd/modules/mod_jk.so"
end
