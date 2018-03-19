#
# Cookbook Name:: stig
# Recipe:: rsyslog_client
# Author: Craig Poma <cpoma@mitre.org>
#
# Description: Configure RSYSLOG Package on a Client
#
#
# CIS Benchmark Items
# RHEL6:  5.1.3
# CENTOS6: 4.1.3
# UBUNTU: 8.2.3
#
###########################################################
# Short Circuit and FAIL if applied to an RSYSLOG server #
#                                                        #
# This should only run on CLIENT NODES                   #
##########################################################
if node['hostname'] =~ /SYSLOG/i
  # Write Error to Screen at top of chef-client run
  # This will make it evident to a person excuting on commandline
  Chef::Log.error('Server name contains the string "SYSLOG". This implies that it is a SYSLOG Server.')
  Chef::Log.error('Cookbook rsyslog_client can only be run on Client node, not the SYSLOG Server.')
  Chef::Log.error("Remove rsyslog_client from the runlist of #{node['hostname']}.")
  Chef::Log.error("If this server is a rsyslog_client remove \"SYSLOG\" from it's name.")

  # Write Error to log file of the chef-client run
  # This will make it visible in the web console
  log 'Not a RSYSLOG Client Error' do
   message 'Server name contains the string "SYSLOG". This implies that it is a SYSLOG Server.'+
	   'Cookbook rsyslog_client can only be run on Client node, not the SYSLOG Server.'+
           "Remove rsyslog_client from the runlist of #{node['hostname']}."+
           "If this server is a rsyslog_client remove \"SYSLOG\" from it's name."
   level :error
  end
  return
end
##########################################################
##########################################################
##########################################################
service 'rsyslog' do
  supports :restart => true, :start => true, :stop => true, :reload => true
  action :nothing
end

directory '/etc/pki/rsyslog' do
  owner 'root'
  group 'root'
  mode  '0700'
  only_if node.default['stig']['rsyslog']['encrypt_traffic'] == 1
end

cookbook_file '/etc/pki/rsyslog/ca.pem' do
  source  'etc_pki_rsyslog_ca.pem'
  owner   'root'
  group   'root'
  mode    '0400'
  notifies :run, "execute[mark_restart_rsyslog]"
  only_if node.default['stig']['rsyslog']['encrypt_traffic'] == 1
  end

# execute "Fix #{node.default['stig']['rsyslog']['server_port']} Port to be Open for SELinux" do
  # command "touch /etc/selinux/rsyslog_chef_port.flag && semanage port -a -t syslogd_port_t -p tcp #{node.default['stig']['rsyslog']['server_port']}"
  # returns [0, 1]
  # not_if do File.exists?('/etc/selinux/rsyslog_chef_port.flag') end
# end

# Install the GNUTLS-UTILS package
# To allow for PKI key creation
package 'gnutls-utils' do
  version "#{node.default['stig']['gnutls-utils']['version']}"
  action :install
  notifies :run, "execute[mark_restart_rsyslog]"
end

# Install the RSYSLOG package
package 'rsyslog' do
  version "#{node.default['stig']['rsyslog']['version']}"
  action :install
  notifies :run, "execute[mark_restart_rsyslog]"
end

# Install the RSYSLOG-GNUTLS package
package 'rsyslog-gnutls' do
  version "#{node.default['stig']['rsyslog-gnutls']['version']}"
  action :install
  notifies :run, "execute[mark_restart_rsyslog]"
end

# Install the RSYSLOG-RELP package
package 'rsyslog-relp' do
  version "#{node.default['stig']['rsyslog-relp']['version']}"
  action :install
  notifies :run, "execute[mark_restart_rsyslog]"
end


syslog_rules = node['stig']['logging']['rsyslog_rules']

#    'debian', 'ubuntu', 'linuxmint' are platforms;
#    'debian' is the platform_family that includes those platforms
if node['platform_family'] == 'debian'
  syslog_rules.concat(node['stig']['logging']['rsyslog_rules_debian'])
end

#    'redhat', 'fedora', 'centos' are platforms;
#    'rhel' is the platform_family that includes those platforms
if node['platform_family'] == 'rhel'
  syslog_rules.concat(node['stig']['logging']['rsyslog_rules_rhel'])
end

template '/etc/rsyslog.conf' do
  source 'etc_rsyslog.conf.erb'
  owner 'root'
  group 'root'
  mode 0o644
  variables(
    rsyslog_rules: node['stig']['logging']['rsyslog_rules'],
	rsyslog_queue_rules: node['stig']['logging']['rsyslog_queue_rules'],
	server_port: node['stig']['rsyslog']['server_port'],
	server_name: node['stig']['rsyslog']['server_name'],
	encrypt_traffic: node['stig']['rsyslog']['encrypt_traffic']
  )
  notifies :run, "execute[mark_restart_rsyslog]"
end

execute "mark_restart_rsyslog" do
  command 'touch /etc/pki/rsyslog/restart_rsyslog.flag'
  action :nothing
  notifies :run, "execute[restart_services_rsyslog]"
end

execute "restart_services_rsyslog" do
  command 'rm -Rf /etc/pki/rsyslog/restart_rsyslog.flag'
  notifies :restart, "service[rsyslog]"
  only_if do File.exists?('/etc/pki/rsyslog/restart_rsyslog.flag') end
end
