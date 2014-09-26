#
# Cookbook Name:: bower
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# EXAMPLE
#  https://github.com/redguide/nodejs/blob/master/test/cookbooks/nodejs_test/recipes/npm.rb

package 'nodejs'
package 'npm'

execute "npm install -g bower" do
  action :run
end

