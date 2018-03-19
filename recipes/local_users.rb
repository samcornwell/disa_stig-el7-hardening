#
# Cookbook Name:: stig
# Recipe:: local_users
# Author: Craig Poma <cpoma@mitre.org>
#
# Description: Remove users and folders that do not belong. Set shells for
# various service accounts.
#
#
# Remove Directories first, some may be related to
# users getting deleted below
node.default['stig']['local_users']['dirs_to_delete']['dir'].each do |dir|
  directory "#{dir}" do
     action :delete
  end
end

execute "Remove the FTP User" do
  command '/usr/sbin/userdel -r ftp'
  only_if %Q{getent passwd ftp}
end

execute "Remove the Gopher User" do
  command '/usr/sbin/userdel -r gopher'
  only_if %Q{getent passwd gopher}
end

execute "Remove the Games User" do
  command '/usr/sbin/userdel -r games'
  only_if %Q{getent passwd games}
end

execute "Change default shell for sync user" do
  command '/usr/bin/chsh -s /sbin/nologin sync'
  not_if %Q{grep -E "(^sync(*.)+/sbin/nologin$)" /etc/passwd}
end

execute "Change default shell for shutdown user" do
  command '/usr/bin/chsh -s /sbin/nologin shutdown'
  not_if %Q{grep -E "(^shutdown(*.)+/sbin/nologin$)" /etc/passwd}
end

execute "Change default shell for halt user" do
  command '/usr/bin/chsh -s /sbin/nologin halt'
  not_if %Q{grep -E "(^halt(*.)+/sbin/nologin$)" /etc/passwd}
end
