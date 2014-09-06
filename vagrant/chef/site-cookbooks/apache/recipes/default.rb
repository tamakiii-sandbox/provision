#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

['httpd', 'httpd-devel', 'mod_ssl'].each do |pkg|
  package "#{pkg}" do
    action :install
  end
end

service 'httpd' do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start]
end

# Prepare log_dir
directory node[:apache][:log_dir] do
  mode '0755'
  owner 'root'
  group node[:apache][:group]
  recursive true
end

# Prepare docroot_dir
directory node[:apache][:docroot_dir] do
  mode '0775'
  owner 'root'
  group node[:apache][:group]
  recursive true
end

# Prepare httpd.conf
template '/etc/httpd/conf/httpd.conf' do
  action:create
  source 'httpd-2.2.conf.erb'
  owner 'root'
  group node[:apache][:group]
  mode '0644'
end
