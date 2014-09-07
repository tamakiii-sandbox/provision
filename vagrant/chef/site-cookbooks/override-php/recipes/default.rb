#
# Cookbook Name:: override-php
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'php'
 
package 'php' do
  action :install
end
