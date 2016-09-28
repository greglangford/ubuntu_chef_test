#
# Cookbook Name:: system
# Recipe:: apt
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Update apt package cache
execute "apt_update" do
  command "apt-get -y update"
end

# The below is not recommended on production systems
# as it may have unintended consequences relating to package version changes.
execute "apt_upgrade" do
  command "apt-get -y upgrade"

  # DEBIAN_FRONTEND env var set to avoid GRUB prompt
  environment "DEBIAN_FRONTEND" => "noninteractive"
end
