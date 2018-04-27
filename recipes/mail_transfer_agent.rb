# Cookbook Name:: stig
# Recipe:: mail_transfer_agent
# Author: Ivan Suftin <isuftin@usgs.gov>
#
# Description: Configure Mail Transfer Agent for Local-Only Mode
#
# CIS Benchmark Items
# RHEL6:  3.1.16
# CENTOS6: 3.16
# Ubuntu 6.15

source = ''
# Fixed to check platform_family versus platform
#    'redhat', 'centos' are platforms;
#    'rhel' is the platform_family that includes those platforms
source = 'etc_main.cf_rhel.erb' if node['platform_family'] == 'rhel'

# Fixed to check platform_family versus platform
#    'debian', 'ubuntu', 'linuxmint' are platforms;
#    'debian' is the platform_family that includes those platforms
source = 'etc_main.cf_ubuntu.erb' if node['platform_family'] == 'debian'

template '/etc/postfix/main.cf' do
  source source
  owner 'root'
  group 'root'
  mode 0o644
  notifies :restart, 'service[postfix]', :immediately
end

service 'postfix' do
  action :nothing
end
