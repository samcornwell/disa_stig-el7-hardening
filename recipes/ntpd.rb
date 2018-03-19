#
# Cookbook Name:: stig
# Recipe:: ntpd
# Author: Craig Poma <cpoma@mitre.org>
#
# Description: Installs and configures NTP
#

# Install the NTP package
package 'ntp' do
  version "#{node.default['stig']['ntpd']['version']}"
  action :install
end

# NTP Configuration
template '/etc/ntp.conf' do
  source  'etc_ntp.conf.erb'
  owner   'root'
  group   'root'
  mode    '0600'
  notifies :run, "execute[mark_restart_ntpd]"
  variables(
    ipv6_active_in_kernel: node['stig']['network']['ipv6_active_in_kernel'],
	disable_ipv6: node['sysctl']['params']['net.ipv6.conf.all.disable_ipv6']
  )
end

# Script to run NTP updates at 15 min past the hour
template '/etc/cron.d/ntpd' do
  source  'etc_crond.d_ntpd.erb'
  owner   'root'
  group   'root'
  mode    '0640'
end

service 'ntpd' do
  action [:enable, :start]
  only_if { node['platform'] == 'redhat' }
end

execute "mark_restart_ntpd" do
  command 'touch /var/tmp/restart_ntpd.flag'
  action :nothing
  notifies :run, "execute[restart_services_ntpd]"
end

execute "restart_services_ntpd" do
  command 'rm -Rf /var/tmp/restart_ntpd.flag'
  notifies :restart, "service[ntpd]"
  only_if do File.exists?('/var/tmp/restart_ntpd.flag') end
end
