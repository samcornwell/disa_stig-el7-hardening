#
# Cookbook Name:: stig
# Recipe:: aide
# Author: David Blodgett <dblodgett@usgs.gov>
#
# Description: Installs Advanced Intrusion Detection Environment (AIDE) and
# implements periodic file checking to comply with site policy
#
# CIS Benchmark Items
# RHEL6: 1.4.1, 1.4.2
# CENTOS6: 1.3.1, 1.3.2
# UBUNTU: 8.3.1, 8.3.2
# - Install AIDE
# - Implement Periodic Execution of File Integrity

platform = node['platform']

# Ensure AIDE is installed
package 'aide'

# Get AIDE attrutes
# TODO: Add defaults for debian/ubuntu platforms
aide_config = {}.merge(node['stig']['aide'].to_h)
if %w[rhel fedora centos].include?(node['platform'])
  platform_version = node['platform_version'].to_i.to_s

  # Set the rules by merging node['stig']['aide']['rules'] with
  # a platform version specific aide_config['rules_rhel']['6'] or
  # node['stig']['aide']['rules_rhel']['default'], which is for RHEL 7+
  aide_config['rules'] =
    if aide_config['rules_rhel'].key?(platform_version)
      aide_config['rules_rhel'][platform_version].merge(aide_config['rules'])
    else
      aide_config['rules_rhel']['default'].merge(aide_config['rules'])
    end

  # Set the paths by merging node['stig']['aide']['paths'] with
  # a platform version specific aide_config['paths_rhel']['6'] or
  # node['stig']['aide']['paths_rhel']['default'], which is for RHEL 7+
  aide_config['paths'] =
    if aide_config['paths_rhel'].key?(platform_version)
      aide_config['paths_rhel'][platform_version].merge(aide_config['paths'])
    else
      aide_config['paths_rhel']['default'].merge(aide_config['paths'])
    end
end

# Configure aide on redhat family
# TODO: Apply template to debian and ubuntu platforms
template node['stig']['aide']['config_file'] do
  action :create
  group 'root'
  mode 0o600
  owner 'root'
  source 'aide.conf.erb'
  variables(config: aide_config)
  only_if { %w[rhel fedora centos redhat].include? platform }
  notifies :run, 'execute[init_aide]', :delayed
end

# CIS Benchmarks suggest: The prelinking feature can interfere with AIDE because it alters binaries to
# speed up their start up times. Run /usr/sbin/prelink -ua to restore the binaries to their prelinked
# state, thus avoiding false positives from AIDE.
# However, prelink is not preinstalled on (at least) 14.04 so there is no need for this yet.

execute 'aideinit' do
  user 'root'
  creates '/var/lib/aide/aide.db.new'
  action :run
  only_if { %w[debian ubuntu].include? platform }
end

remote_file '/var/lib/aide/aide.db' do
  user 'root'
  source 'file:///var/lib/aide/aide.db.new'
  only_if { %w[debian ubuntu].include? platform }
end

aide_database = node['stig']['aide']['database'].gsub('@@{DBDIR}', node['stig']['aide']['dbdir'])
execute 'init_aide' do
  user 'root'
  command "/usr/sbin/aide --init -B 'database_out=#{aide_database}'"
  action :nothing
  only_if { %w[rhel fedora centos redhat].include? platform }
end

cron 'aide_cron' do
  command '/usr/sbin/aide --check'
  minute '0'
  hour '5'
  day '*'
  month '*'
  action :create
  not_if 'crontab -u root -l | grep aide'
end
