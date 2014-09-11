#
# Cookbook Name:: web-front
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'localedef'
include_recipe 'vim'
include_recipe 'zsh'
include_recipe 'chsh'
include_recipe 'tree'

include_recipe 'override-php'
include_recipe 'override-apache'
include_recipe 'override-mysql'
