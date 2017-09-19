
# CENTOS6: 9.1.10
# UBUNTU: 12.7
describe command("df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -type f -perm -0002 -print") do
  its(:stdout) { should match /^$/ }
end

# CENTOS6: 9.1.11
# UBUNTU: 12.8
describe command("df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nouser -ls") do
  its(:stdout) { should match /^$/ }
end

# CENTOS6: 9.1.12
# UBUNTU: 12.9
describe command("df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nogroup -ls") do
  its(:stdout) { should match /^$/ }
end

# CENTOS6: 9.2.1
# UBUNTU: 13.1
describe command("/bin/cat /etc/shadow | /bin/awk -F: '($2 == \"\" ) { print $1 \" does not have a password \"}'") do
  its(:stdout) { should match /^$/ }
end

# CENTOS6: 9.2.2
# UBUNTU: 13.2
describe command("grep '^+:' /etc/passwd") do
  its(:stdout) { should match /^$/ }
end

# CENTOS6: 9.2.3
# UBUNTU: 13.3
describe command("grep '^+:' /etc/shadow") do
  its(:stdout) { should match /^$/ }
end

# CENTOS6: 9.2.4
# UBUNTU: 13.4
describe command("grep '^+:' /etc/group") do
  its(:stdout) { should match /^$/ }
end

# CENTOS6: 9.2.5
# UBUNTU: 13.5
describe command("/bin/cat /etc/passwd | /bin/awk -F: '($3 == 0) { print $1 }'") do
  its(:stdout) { should match /root/ }
end
