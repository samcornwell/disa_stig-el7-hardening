# Cookbook Name:: stig
# Recipe:: login_defs
# Author: Ivan Suftin <isuftin@usgs.gov>
#
# Description: Update account expiration definitions
#
# CIS Benchmark Items
# RHEL6: 7.2.1, 7.2.2, 7.2.3
# CENTOS6: 7.1.1, 7.1.2, 7.1.3
# UBUNTU: 10.1.1, 10.1.2, 10.1.3
#
# - Set Password Expiration Days
# - Set Password Change Minimum Number of Days
# - Set Password Expiring Warning Days
#
# CIS Benchmark v2.2.0
# RHEL 7: 5.4.1.4 Ensure inactive password lock is 30 days or less (Scored)


template '/etc/login.defs' do
  source 'etc_login.defs.erb'
  owner 'root'
  group 'root'
  mode 0o644
  variables(
    pass_max_days: node['stig']['login_defs']['pass_max_days'],
    pass_min_days: node['stig']['login_defs']['pass_min_days'],
    pass_min_length: node['stig']['login_defs']['pass_min_length'],
	pass_warn_age: node['stig']['login_defs']['pass_warn_age'],
	umask: node['stig']['login_defs']['umask'],
	fail_delay: node['stig']['login_defs']['fail_delay']
  )
end

template '/etc/default/useradd' do
  source 'etc_default_useradd.erb'
  owner 'root'
  group 'root'
  mode 0o600
  variables(
	inactive_days: node['stig']['login_defs']['inactive_days']
  )
end

execute "Check for INACTIVE Days Setting" do
  command "useradd -D --inactive #{node['stig']['login_defs']['inactive_days']}"
# Only run if INACTIVE=node['stig']['login_defs']['inactive_days'] is NOT Set
  not_if %Q{useradd -D | grep INACTIVE=#{node['stig']['login_defs']['inactive_days']}}
end
