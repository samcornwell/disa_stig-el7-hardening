
describe file('/etc/audit/audit.rules') do
  it { should exist }
  it { should be_file }
  its('mode') { should cmp '0640' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its('content') { should include('-w /etc/group -p wa -k identity') }
  its('content') { should include('-w /etc/issue -p wa -k system-locale') }
  its('content') { should include('-a always,exit -F arch=b32 -S adjtimex -S settimeofday -S stime -k time-change') }
  its('content') { should include('-a always,exit -F arch=b64 -S adjtimex -S settimeofday -k time-change') }
  its('content') { should include('-a always,exit -F arch=b32 -S clock_settime -F a0=0 -k time-change') }
  its('content') { should include('-a always,exit -F arch=b64 -S clock_settime -F a0=0 -k time-change') }
  its('content') { should include('-w /etc/localtime -p wa -k time-change') }
  its('content') { should include('-w /etc/group -p wa -k identity') }
  its('content') { should include('-w /etc/passwd -p wa -k identity') }
  its('content') { should include('-w /etc/gshadow -p wa -k identity') }
  its('content') { should include('-w /etc/shadow -p wa -k identity') }
  its('content') { should include('-w /etc/security/opasswd -p wa -k identity') }
  its('content') { should include('-a always,exit -F arch=b32 -S sethostname -S setdomainname -k system-locale') }
  its('content') { should include('-a always,exit -F arch=b64 -S sethostname -S setdomainname -k system-locale') }
  its('content') { should include('-w /etc/issue -p wa -k system-locale') }
  its('content') { should include('-w /etc/issue.net -p wa -k system-locale') }
  its('content') { should include('-w /etc/hosts -p wa -k system-locale') }
  its('content') { should include('-w /etc/sysconfig/network -p wa -k system-locale') }
  its('content') { should include('-w /etc/selinux/ -p wa -k MAC-policy') }
  its('content') { should include('-a always,exit -F arch=b32 -S chmod -S fchmod -S fchmodat -F auid>=500 -F auid!=4294967295 -k perm_mod') }
  its('content') { should include('-a always,exit -F arch=b64 -S chmod -S fchmod -S fchmodat -F auid>=500 -F auid!=4294967295 -k perm_mod') }
  its('content') { should include('-a always,exit -F arch=b32 -S chown -S fchown -S fchownat -S lchown -F auid>=500 -F auid!=4294967295 -k perm_mod') }
  its('content') { should include('-a always,exit -F arch=b64 -S chown -S fchown -S fchownat -S lchown -F auid>=500 -F auid!=4294967295 -k perm_mod') }
  its('content') { should include('-a always,exit -F arch=b32 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=500 -F auid!=4294967295 -k perm_mod') }
  its('content') { should include('-a always,exit -F arch=b64 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=500 -F auid!=4294967295 -k perm_mod') }
  its('content') { should include('-a always,exit -F arch=b32 -S creat -S open -S openat -S open_by_handle_at -S truncate -F exit=-EACCES -F auid>=500 -F auid!=4294967295 -k access') }
  its('content') { should include('-a always,exit -F arch=b32 -S creat -S open -S openat -S open_by_handle_at -S truncate -F exit=-EPERM -F auid>=500 -F auid!=4294967295 -k access') }
  its('content') { should include('-a always,exit -F arch=b64 -S creat -S open -S openat -S open_by_handle_at -S truncate -F exit=-EACCES -F auid>=500 -F auid!=4294967295 -k access') }
  its('content') { should include('-a always,exit -F arch=b64 -S creat -S open -S openat -S open_by_handle_at -S truncate -F exit=-EPERM -F auid>=500 -F auid!=4294967295 -k access') }
  its('content') { should include('-a always,exit -F path=/bin/ping -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged') }
  its('content') { should include('-a always,exit -F arch=b32 -S mount -F auid>=500 -F auid!=4294967295 -k export') }
  its('content') { should include('-a always,exit -F arch=b64 -S mount -F auid>=500 -F auid!=4294967295 -k export') }
  its('content') { should include('-w /etc/sudoers -p wa -k actions') }
  its('content') { should include('-w /var/log/faillog -p wa -k logins') }
  its('content') { should include('-w /var/log/lastlog -p wa -k logins') }
  its('content') { should include('-w /var/log/btmp -p wa -k session') }
  its('content') { should include('-w /var/run/utmp -p wa -k session') }
  its('content') { should include('-w /var/log/wtmp -p wa -k session') }
  its('content') { should include('-a always,exit -F arch=b64 -S mount -F auid>=500 -F auid!=4294967295 -k mounts') }
  its('content') { should include('-a always,exit -F arch=b32 -S mount -F auid>=500 -F auid!=4294967295 -k mounts') }
  its('content') { should include('-a always,exit -F arch=b64 -S unlink -S unlinkat -S rename -S renameat -F auid>=500 -F auid!=4294967295 -k delete') }
  its('content') { should include('-a always,exit -F arch=b32 -S unlink -S unlinkat -S rename -S renameat -F auid>=500 -F auid!=4294967295 -k delete') }
  its('content') { should include('-w /var/log/sudo.log -p wa -k actions') }
  its('content') { should include('-w /sbin/insmod -p x -k modules') }
  its('content') { should include('-w /sbin/rmmod -p x -k modules') }
  its('content') { should include('-w /sbin/modprobe -p x -k modules') }
  its('content') { should include('-a always,exit -F arch=b64 -S init_module -S delete_module -k modules') }
  its('content') { should include('-a always,exit -F arch=b32 -S init_module -S delete_module -k modules') }
  its('content') { should include('-b 8192') }
  its('content') { should include('-f 1') }
  its('content') { should include('-D') }
end
