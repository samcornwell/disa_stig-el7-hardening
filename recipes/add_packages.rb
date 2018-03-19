
#
# Cookbook Name:: stig
# Recipe:: add_packages
# Author: Craig Poma <cpoma@mitre.org>
#
# Description: Add required packages
# implements periodic file checking to comply with site policy
#
# CIS Benchmark Items
# RHEL6: 1.4.1, 1.4.2
# CENTOS6: 1.3.1, 1.3.2
# UBUNTU: 8.3.1, 8.3.2

# RHEL 7 CCI / CCE
# CCE-27351-6
# CCI-000057
#

# Install the OPENSWAN package
# Package openswan-2.6.32-37.el6.x86_64 is obsoleted
# by libreswan-3.15-5.3.el6.x86_64
#package 'openswan' do
#  version '2.6.32-37.el6'
#  action :install
#end
package 'libreswan' do
  version "#{node.default['stig']['libreswan']['version']}"
  action :install
end

# Install the screen package for STIG compliance
# Install the screen package to allow the initiation a session lock after
# a 15-minute period of inactivity for graphical users interfaces
# CCE-27351-6
# CCI-000057
package 'screen' do
  version "#{node.default['stig']['screen']['version']}"
  action :install
end

# Install the CRON Scheduling Services package
package 'cronie' do
  version "#{node.default['stig']['cronie']['version']}"
  action :install
end

# STIG Doesn't Want cronie-anacron
#package 'cronie-anacron' do
#  version "#{node.default['cronie']['version']}"
#  action :install
#end

package 'crontabs' do
  version "#{node.default['stig']['crontabs']['version']}"
  action :install
end

# STIG Packages for Multi-factor Authentication
package 'esc' do
  version "#{node.default['stig']['esc']['version']}"
  action :install
end

package 'pam_pkcs11' do
  version "#{node.default['stig']['pam_pkcs11']['version']}"
  action :install
end

template "/etc/pam_pkcs11/pam_pkcs11.conf" do
  source 'etc_pam_pkcs11_pam_pkcs11.conf.erb'
  owner 'root'
  group 'root'
  mode 0o644
end

package 'authconfig-gtk' do
  version "#{node.default['stig']['authconfig-gtk']['version']}"
  action :install
end

#STIG Packages for Crypto
package 'dracut-fips' do
  version "#{node.default['stig']['dracut-fips']['version']}"
  action :install
end
