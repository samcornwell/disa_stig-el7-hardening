#
# Cookbook Name:: stig
# Recipe:: fstab_tmp
# Author: Ivan Suftin <isuftin@usgs.gov>
#
# Description: Update mounts to comply with CIS reccomendations
#
# CIS Benchmark Items

# RHEL6: 1.1.2, 1.1.3, 1.1.4, 1.1.6, 1.14, 1.1.15, 1.1.16
# CENTOS6: 1.1.2, 1.1.3, 1.1.4, 1.1.6, 1.1.14, 1.1.15, 1.1.16
# CENTOS7: 1.1.2, 1.1.3, 1.1.4, 1.1.6, 1.1.14, 1.1.15, 1.1.16
# UBUNTU: 2.2, 2.3, 2.4, 2.6, 2.14, 2.15, 2.16
# TODO: UBUNTU 2.1 - Need to figure out LVM to create new /tmp partition
# since a separate /tmp partition does not exist by default

# - Set nodev option for /tmp Partition
# - Set nosuid option for /tmp Partition
# - Set noexec option for /tmp Partition
# - Bind Mount the /var/tmp directory to /tmp

platform = node['platform']

var_tmp = '/var/tmp'
tmp = '/tmp'

# This block executes unless service is marked as enabled.
ruby_block "get service status" do
    block do
      Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)
      command1 = "systemctl is-enabled tmp.mount"
      command_out = shell_out(command1)
      node.default['tmp_mount']['service_state'] = command_out.stdout
    end
    not_if (node.default['tmp_mount']['service_state'] == 'enabled')
    action :create
end

execute 'unmask tmp.mount service' do
   command 'rm /etc/systemd/system/tmp.mount'
   only_if { ::File.exist?('/etc/systemd/system/tmp.mount') }
   only_if (node.default['tmp_mount']['service_state'] == 'masked')
end

#STIG V-72065: The system must use a separate file system for /tmp (or equivalent).
service 'tmp.mount' do
  supports :restart => true, :start => true, :stop => true, :reload => true, :enable => true, :disable => true
  action [:enable, :start]
end

mount var_tmp do
  fstype   'tmpfs'
  device   tmp
  options  'bind'
  not_if 'mount | grep /var/tmp'
end

mount '/run/shm' do
  fstype 'tmpfs'
  device 'none'
  options 'rw,nodev,nosuid,noexec'
  action %i[mount enable]
  notifies :run, 'execute[remount]', :immediately
  only_if { %w[debian ubuntu].include? platform }
end

# The initial mount for whatever reason doesn't seem to mount
# with the noexec flag. I need to remount after noexec is written
# to fstab
execute 'remount' do
  command 'mount -o remount /run/shm'
  action :nothing
  only_if { %w[debian ubuntu].include? platform }
end

mount '/dev/shm' do
  fstype 'tmpfs'
  device 'none'
  options 'nodev,nosuid,noexec'
  enabled true
  action %i[mount enable]
  only_if { %w[rhel fedora centos].include? platform }
end
