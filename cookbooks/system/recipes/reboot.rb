#
# Cookbook Name:: system
# Recipe:: reboot
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# We could add a not_if guard here to check for a lockfile or node variable
# otherwise under chef server mode this will reboot on every converge
reboot "end_of_converge_reboot" do
  action :request_reboot
end
