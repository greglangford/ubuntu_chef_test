#
# Cookbook Name:: ufw
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

platform_family = node[:platform_family]

if not platform_family == "debian"
  Chef::Log.warn("Only able to install UFW on platform_family debian")
else
  package "ufw" do
    action :install
  end

  service "ufw" do
    action :enable
  end
end
