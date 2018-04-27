# Cookbook Name:: stig
# Recipe:: boot_settings
# Author: Ivan Suftin <isuftin@usgs.gov>
#
# Description: Configure boot settings
#
# CIS Benchmark Items

# RHEL6:  1.5.2, 1.5.3, 1.5.4, 1.5.5, 1.5.6, 1.6.1, 1.6.2, 1.6.3, 1.6.4, 4.2.1, 4.2.2, 4.2.3
# CENTOS6: 1.4.1, 1.4.2, 1.4.3, 1.4.4, 1.4.5, 1.4.6, 1.5.1, 1.5.2, 1.5.3, 1.5.5, 5.2.1, 5.2.2, 5.2.3
# UBUNTU: 3.1, 3.2,
# - Enable SELinux in /etc/grub.conf.
# - Set SELinux state
# - Set SELinux policy
# - Remove SETroubleshoot
# - Remove MCS Translation Service
# - Check for unconfined daemons - NOTE: This doesn't have an action plan associated with it
# - Set User/Group Owner on /etc/grub.conf
# - Set Permissions on /etc/grub.conf
# - Set Boot Loader Password
# - Require Authentication for Single-User Mode.
# - Disable Interactive Boot.
# - Disable Source Routed Packet Acceptance
# - Disable ICMP Redirect Acceptance
# - Disable Secure ICMP Redirect Acceptance

platform = node['platform']

# Get major version for RHEL distro
major_version = node['platform_version'][0, 1].to_i

template '/etc/grub.d/40_custom' do
  source 'etc_grubd_40_custom.erb'
  variables(
    pass: node['stig']['grub']['hashedpassword']
  )
  sensitive true
  notifies :run, 'execute[update-grub]', :immediately
  only_if { %w[debian ubuntu].include? platform }
end

execute 'update-grub' do
  action :nothing
  only_if { %w[debian ubuntu].include? platform }
end

# TODO: support for UEFI?
grub_file =
  if node['platform_family'] == 'rhel' && major_version < 7
    '/boot/grub/grub.conf'
  else
    '/boot/grub2/grub.cfg'
  end

# This is not scored (or even suggested by CIS) in Ubuntu
file grub_file do
  owner 'root'
  group 'root'
  mode '0o600'
  only_if { node['platform_family'] == 'rhel' }
end

# TODO: rewrite for grub2, we shouldn't be manipulating grub.cfg directly
# 1.4.1
execute 'Remove selinux=0 from grub file' do
  command "sed -i 's/selinux=0//' #{grub_file}"
  only_if "grep -q 'selinux=0' #{grub_file}"
  only_if { node['platform_family'] == 'rhel' }
end

execute 'Remove enforcing=0 from grub file' do
  command "sed -i 's/enforcing=0//' #{grub_file}"
  only_if "grep -q 'enforcing=0' #{grub_file}"
  only_if { node['platform_family'] == 'rhel' }
end

# V-72067 Add fips=1 to end of line kernel lines
# TODO: re-examine and modify to work on rhel/centos 6 only
# execute 'enable fips for kernel modes' do
#   command "sed -i '/kernel/ s/$/ fips=1/g' /boot/grub/grub.conf"
#   not_if %Q{grep "fips=1" /boot/grub/grub.conf}
# end

execute 'enable fips for kernel modes' do
  command "sed -i '/GRUB_CMDLINE_LINUX/ s/\"\s*$/ fips=1\"/g' /etc/default/grub"
  notifies :run, 'execute[rebuild_grub_config]'
  not_if { node['platform_family'] == 'rhel' and major_version < 7 }
  not_if %Q{grep "GRUB_CMDLINE_LINUX" /etc/default/grub | grep "fips=1"}
end

# TODO: re-examine and modify to work on rhel/centos 6 only
# Add audit=1 to end of line kernel lines
# execute 'enable audit for kernel modes' do
#   command "sed -i '/kernel/ s/$/ audit=1/g' /boot/grub/grub.conf"
#   not_if %Q{grep "audit=1" /boot/grub/grub.conf}
# end

execute 'enable audit for kernel modes' do
  command "sed -i '/GRUB_CMDLINE_LINUX/ s/\"\s*$/ audit=1\"/g' /etc/default/grub"
  notifies :run, 'execute[rebuild_grub_config]'
  not_if { node['platform_family'] == 'rhel' and major_version < 7 }
  not_if %Q{grep "GRUB_CMDLINE_LINUX" /etc/default/grub | grep "audit=1"}
end

# force grub2 rebuild if audit=1 not found on all boot config lines
execute 'check for fips=1' do
  command %Q{true}
  notifies :run, 'execute[rebuild_grub_config]'
  not_if { node['platform_family'] == 'rhel' and major_version < 7 }
  only_if %Q{grep "^\\s*linux" #{grub_file} | grep -v "fips=1"}
end

# force grub2 rebuild if audit=1 not found on all boot config lines
execute 'check for audit=1' do
  command %Q{true}
  notifies :run, 'execute[rebuild_grub_config]'
  not_if { node['platform_family'] == 'rhel' and major_version < 7 }
  only_if %Q{grep "^\\s*linux" #{grub_file} | grep -v "audit=1"}
end

execute 'rebuild_grub_config' do
  user 'root'
  command %Q{grub2-mkconfig -o #{grub_file}}
  action :nothing
end

# 1.5.3
password = node['stig']['grub']['hashedpassword']
execute 'Add MD5 password to grub' do
  command "sed -i '11i password --md5 #{password}' #{grub_file}"
  not_if "grep -q '#{password}' #{grub_file}"
  only_if { node['platform_family'] == 'rhel' }
  only_if { major_version < 7 }
  only_if { node['stig']['grub']['hashedpassword'] != '' }
end

execute 'Add password to grub' do
  command "sed -i '/password/d' #{grub_file}"
  only_if "grep -q 'password' #{grub_file}"
  only_if { node['platform_family'] == 'rhel' }
  only_if { major_version < 7 }
  only_if { node['stig']['grub']['hashedpassword'] == '' }
end

# TODO: Create adding password to grub for CentOS 7
# Programtically using grub2-mkpasswd-pbkdf2: echo -e 'mypass\nmypass' | grub2-mkpasswd-pbkdf2 | awk '/grub.pbkdf/{print$NF}'
# Hardcoded to P@ssword1234 right now
file '/boot/grub2/user.cfg' do
  content "GRUB2_PASSWORD=grub.pbkdf2.sha512.10000.01474AE866046E7E634CCF7B7CFA81B34406735649B71519D1A5C980C10B89EED344150ECBCAAAE452FF2DC4F86E9AA55E38EFE062ACF04A94D35BE5A3E42D3E.18CCE00C6AB2C44F7FCEE6BBD25901E2868385C79CD9D710C7D0065325886ED104DDE2151A4FC9CDDC5BE501A5AA507EE1DE859029EBCE3EB72A969F50BBF297\n"
  mode 0o600
  owner 'root'
  group 'root'
end

cookbook_file '/etc/inittab' do
  source 'etc_inittab'
  only_if { node['platform_family'] == 'rhel' }
  only_if { major_version < 7 }
end

enabled_selinux = node['stig']['selinux']['enabled']
status_selinux = node['stig']['selinux']['status']
type_selinux = node['stig']['selinux']['type']

template '/etc/selinux/config' do
  source 'etc_selinux_config.erb'
  owner 'root'
  group 'root'
  variables(enabled_selinux: enabled_selinux,
            status_selinux: status_selinux,
            type_selinux: type_selinux)
  mode 0o644
  sensitive true
  notifies :run, 'execute[toggle_selinux]', :delayed
  only_if { node['platform_family'] == 'rhel' }
end

link '/etc/sysconfig/selinux' do
  to '/etc/selinux/config'
  only_if { node['platform_family'] == 'rhel' }
end

template '/selinux/enforce' do
  source 'selinux_enforce.erb'
  owner 'root'
  group 'root'
  variables(enforcing: (enabled_selinux ? 1 : 0))
  only_if { ::File.directory?('/selinux') }
  only_if { node['platform_family'] == 'rhel' }
  mode 0o644
end

# Do not run this if selinux is already in the state we expect or if disabled.
# If disabled, running setenforce fails so do not run setenforce if selinux is disabled
execute 'toggle_selinux' do
  command "setenforce #{(enabled_selinux ? 1 : 0)}"
  not_if "echo $(getenforce) | awk '{print tolower($0)}' | grep -q -E '(#{status_selinux}|disabled)'"
  ignore_failure true
  only_if { node['platform_family'] == 'rhel' }
end

# TODO: Ensure authentication required for single user mode for CentOS 7
template '/etc/sysconfig/init' do
  source 'etc_sysconfig_init.erb'
  owner 'root'
  group 'root'
  mode 0o644
  only_if { node['platform_family'] == 'rhel' }
  only_if { major_version < 7 }
end

package 'setroubleshoot' do
  action :remove
end

package 'mcstrans' do
  action :remove
end

#V-72057: Kernel core dumps must be disabled unless needed.
service 'kdump' do
  action [:disable, :stop]
end
