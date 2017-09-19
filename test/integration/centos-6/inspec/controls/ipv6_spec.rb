describe package('iptables-services') do
  it { should_not be_installed }
end

describe service('iptables') do
  it { should be_installed }
  it { should be_enabled }
end

describe service('ip6tables') do
  it { should be_installed }
end

describe file('/etc/sysconfig/network') do
  it { should be_file }
  its('mode') { should cmp '0644' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/etc/modprobe.d/ipv6.conf') do
  it { should be_file }
  its('mode') { should cmp '0644' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end
