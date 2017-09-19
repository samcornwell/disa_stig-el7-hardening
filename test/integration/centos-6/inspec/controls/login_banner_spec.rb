

# CENTOS 8.1
# UBUNTU 11.1
describe file('/etc/motd') do
  it { should be_file }
  its('mode') { should cmp '0644' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end
describe file('/etc/issue') do
  it { should be_file }
  its('mode') { should cmp '0644' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end
describe file('/etc/issue.net') do
  it { should be_file }
  its('mode') { should cmp '0644' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

# CENTOS 8.2
# UBUNTU 11.2
describe command("egrep '(\\v|\\r|\\m|\\s)' /etc/issue") do
  its(:stdout) { should match /^$/ }
end
describe command("egrep '(\\v|\\r|\\m|\\s)' /etc/motd") do
  its(:stdout) { should match /^$/ }
end
describe command("egrep '(\\v|\\r|\\m|\\s)' /etc/issue.net") do
  its(:stdout) { should match /^$/ }
end
