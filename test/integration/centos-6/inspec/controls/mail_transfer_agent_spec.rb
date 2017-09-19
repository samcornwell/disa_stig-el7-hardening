
describe file('/etc/postfix/main.cf') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its('mode') { should cmp '0644' }
end

# Ubuntu 6.15
# CENTOS6: 3.16
describe command('netstat -an | grep LIST | grep ":25 "') do
  its(:stdout) { should match /127.0.0.1/ }
end

describe service('postfix') do
  it { should be_enabled }
  it { should be_running }
end
