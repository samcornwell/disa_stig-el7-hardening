#
# Cookbook Name:: stig
# Recipe:: inittab
# Author: Craig Poma <cpoma@mitre.org>
#
# Description: This cookbook password protects Linux single user mode.
#
template '/etc/inittab' do
  source  'etc_inittab.erb'
  owner   'root'
  group   'root'
  mode    '0644'
end
