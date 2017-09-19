

# CENTOS6: 6.2.2, 6.2.3, 6.2.5, 6.2.6, 6.2.7, 6.2.8, 6.2.9, 6.2.10, 6.2.13, 6.2.14
# UBUNTU: 9.3.1, 9.3.2, 9.3.5, 9.3.3, 9.3.6, 9.3.7, 9.3.8, 9.3.9, 9.3.10, 9.3.13, 9.3.14

describe file('/etc/ssh/sshd_config') do
  it { should exist }
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its('mode') { should cmp '0600' }
  # CENTOS6: 6.2.2
  # UBUNTU: 9.3.1
  its('content') { should include('Protocol 2') }
  # CENTOS6: 6.2.3
  # UBUNTU: 9.3.2
  its('content') { should include('LogLevel INFO') }
  # CENTOS: 6.2.5
  # UBUNTU: 9.3.5
  its('content') { should match /MaxAuthTries [1-4]/ }
  # CENTOS: 6.2.6
  # UBUNTU: 9.3.6
  its('content') { should include('IgnoreRhosts yes') }
  # CENTOS: 6.2.7
  # UBUNTU: 9.3.7
  its('content') { should include('HostbasedAuthentication no') }
  # CENTOS: 6.2.8
  # UBUNTU: 9.3.8
  its('content') { should include('PermitRootLogin no') }
  # CENTOS: 6.2.9
  # UBUNTU: 9.3.9
  its('content') { should include('PermitEmptyPasswords no') }
  # CENTOS: 6.2.10
  # UBUNTU: 9.3.10
  its('content') { should include('PermitUserEnvironment no') }
  # CENTOS: 6.2.13
  # UBUNTU: 9.3.13
  its('content') { should_not include('AllowUsers') }
  its('content') { should_not include('AllowGroups') }
  its('content') { should include('DenyUsers bin,daemon,adm,lp,mail,uucp,operator,games,gopher,ftp,nobody,vcsa,rpc,saslauth,postfix,rpcuser,nfsnobody,sshd') }
  its('content') { should_not include('DenyGroups') }
  # CENTOS: 6.2.14
  # UBUNTU: 9.3.14
  its('content') { should include('Banner /etc/issue.net') }

  # RHEL6: 6.2.11
  its('content') { should include('Ciphers aes128-ctr,aes192-ctr,aes256-ctr') }

  its('content') { should include('ChallengeResponseAuthentication no') }
  its('content') { should include('UsePAM yes') }
  its('content') { should include('GSSAPIKeyExchange no') }
  its('content') { should include('GSSAPICleanupCredentials yes') }
end
