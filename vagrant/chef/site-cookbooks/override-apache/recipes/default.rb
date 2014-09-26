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

# vuejs
web_app "vuejs" do
  docroot "/web/httpd/vuejs/public"
  template "vuejs.conf.erb"
  server_name node[:fqdn]
  server_aliases [node[:hostname], "vuejs"]
end

# hq_app
web_app "hq_app" do
  template "vh.conf.erb"
  docroot "/web/httpd/hq_app/public/web"
  server_name "hq_app.vagrant"
  server_aliases [node[:hostname], "hq_app"]
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

directory "/var/log/app_preserve/zucks" do
  action :create
  owner 'root'
  group node['apache']['root_group']
  mode '0775'
  recursive true
end

# enable
apache_site 'vuejs.conf' do
  enable true
end
apache_site 'hq_app.conf' do
  enable true
end
