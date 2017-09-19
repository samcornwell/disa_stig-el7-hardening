
describe file('/etc/modprobe.d/CIS.conf') do
  it { should exist }
  it { should be_file }
  it { should be_owned_by 'root' }
  its('mode') { should cmp '0644' }
end

# UBUNTU 2.18
# CENTOS 1.1.18
describe command('/sbin/modprobe -n -v cramfs') do
  its(:stdout) { should match /install \/bin\/true/ }
end
describe command('/sbin/lsmod | grep cramfs') do
  its(:stdout) { should match /^$/ }
end

# UBUNTU 2.19
# CENTOS 1.1.19
describe command('/sbin/modprobe -n -v freevxfs') do
  its(:stdout) { should match /install \/bin\/true/ }
end
describe command('/sbin/lsmod | grep freevxfs') do
  its(:stdout) { should match /^$/ }
end

# UBUNTU 2.20
# CENTOS 1.1.20
describe command('/sbin/modprobe -n -v jffs2') do
  its(:stdout) { should match /install \/bin\/true/ }
end
describe command('/sbin/lsmod | grep jffs2') do
  its(:stdout) { should match /^$/ }
end

# UBUNTU 2.21
# CENTOS 1.1.21
describe command('/sbin/modprobe -n -v hfs') do
  its(:stdout) { should match /install \/bin\/true/ }
end
describe command('/sbin/lsmod | grep hfs') do
  its(:stdout) { should match /^$/ }
end

# UBUNTU 2.22
# CENTOS 1.1.22
describe command('/sbin/modprobe -n -v hfsplus') do
  its(:stdout) { should match /install \/bin\/true/ }
end
describe command('/sbin/lsmod | grep hfsplus') do
  its(:stdout) { should match /^$/ }
end

# UBUNTU 2.23
# CENTOS 1.1.23
describe command('/sbin/modprobe -n -v squashfs') do
  its(:stdout) { should match /install \/bin\/true/ }
end
describe command('/sbin/lsmod | grep squashfs') do
  its(:stdout) { should match /^$/ }
end

# UBUNTU 2.24
# CENTOS 1.1.24
describe command('/sbin/modprobe -n -v udf') do
  its(:stdout) { should match /install \/bin\/true/ }
end
describe command('/sbin/modprobe -n -v vfat') do
  its(:stdout) { should match /install \/bin\/true/ }
end
describe command('/sbin/lsmod | grep udf') do
  its(:stdout) { should match /^$/ }
end

# UBUNTU 7.5.1
# CENTOS 5.6.1
describe command('grep "install dccp /bin/true" /etc/modprobe.d/CIS.conf | tr -d "\n"') do
  its(:stdout) { should match /install dccp \/bin\/true/ }
end

# UBUNTU 7.5.2
# CENTOS 5.6.2
describe command('grep "install sctp /bin/true" /etc/modprobe.d/CIS.conf | tr -d "\n"') do
  its(:stdout) { should match /install sctp \/bin\/true/ }
end

# UBUNTU 7.5.3
# CENTOS 5.6.3
describe command('grep "install rds /bin/true" /etc/modprobe.d/CIS.conf | tr -d "\n"') do
  its(:stdout) { should match /install rds \/bin\/true/ }
end

# UBUNTU 7.5.4
# CENTOS 5.6.4
describe command('grep "install tipc /bin/true" /etc/modprobe.d/CIS.conf | tr -d "\n"') do
  its(:stdout) { should match /install tipc \/bin\/true/ }
end

describe command('grep "options ipv6 disable=1" /etc/modprobe.d/CIS.conf | tr -d "\n"') do
  its(:stdout) { should match /options ipv6 disable=1/ }
end
