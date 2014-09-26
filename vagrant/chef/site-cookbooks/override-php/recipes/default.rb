#
# Cookbook Name:: override-php
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'php'
include_recipe "php::module_mysql"
include_recipe "apache2::mod_php5"
 
package 'php' do
  action :install
end

ruby_block "modify php.ini" do
    block do
        f = Chef::Util::FileEdit.new("/etc/php.ini")
        f.search_file_replace(/;date.timezone =/, "date.timezone = 'Asia/Tokyo'")
        f.write_file
    end
end
