#
# Cookbook Name:: stig
# Recipe:: auditd
# Author: Ivan Suftin < isuftin@usgs.gov >
#
# Description: Installs the auditd cookbook with the CIS ruleset
#
# See: https://supermarket.chef.io/cookbooks/auditd

auditd_config_dir = '/etc/audit/'

directory auditd_config_dir

# Create auditd configuration file
template File.join(auditd_config_dir, 'auditd.conf') do
  source 'etc_audit_auditd.conf.erb'
  owner 'root'
  group 'root'
  mode 0o640
  notifies :reload, 'service[auditd]', :immediately
end

# V-72087
# Taking appropriate action in case of a filled audit storage volume will
# minimize the possibility of losing audit records.
template '/etc/audisp/audisp-remote.conf' do
  source 'etc_audisp_audisp-remote.conf.erb'
  owner 'root'
  group 'root'
  mode 0o644
  variables(
    audisp_remote_rules: node['stig']['auditd']['config']['audisp_remote_rules']
  )
end
