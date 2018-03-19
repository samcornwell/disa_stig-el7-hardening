#
# Cookbook Name:: stig
# Recipe:: yum
# Author: Craig Poma <cpoma@mitre.org>
#
# Description: Configure YUM Package Manager
#
# YUM CONFIG
template "/etc/yum.conf" do
   source "etc_yum.conf.erb"
   owner 'root'
   group 'root'
   mode  '0644'
   variables(
    proxy_ip: node['stig']['yum']['proxy_ip']
  )
end

file '/etc/cron.daily/yum.cron' do
  content '# Purposely empty. We do not want to automatically check for updates to install'
  owner 'root'
  group 'root'
  mode '0700'
end
