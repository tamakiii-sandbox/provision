#
# Cookbook Name:: override-apache
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apache2'

# disable default site
apache_site '000-default' do
  enable false
end

# create directory
directory '/web/httpd' do
  action :create
  recursive true
end

# Set up config
web_app "vuejs" do
  docroot "/web/httpd/vuejs/public"
  template "vuejs.conf.erb"
  server_name node[:fqdn]
  server_aliases [node[:hostname], "vuejs"]
end

template 'apache2.conf' do
  path "#{node['apache']['conf_dir']}/httpd.conf"
  action :create
  source 'apache2.conf.erb'
  owner 'root'
  group node['apache']['root_group']
  mode '0644'
  notifies :reload, 'service[apache2]', :delayed
end

# enable
apache_site 'vuejs.conf' do
  enable true
end

