

# CENTOS6: 6.3.4
# UBUNTU: 9.2.3
describe file('/etc/pam.d/password-auth') do
  it { should be_file }
  it { should exist }
  it { should be_linked_to '/etc/pam.d/password-auth-ac' }
end

describe file('/etc/pam.d/password-auth-ac') do
  it { should be_file }
  it { should exist }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its('mode') { should cmp '0644' }
  its('content') { should include('auth        required      pam_env.so') }
  its('content') { should include('auth        required      pam_faillock.so preauth audit silent deny=5 unlock_time=900') }
  its('content') { should include('auth        sufficient    pam_unix.so nullok try_first_pass') }
  its('content') { should include('auth        sufficient    pam_faillock.so authsucc audit deny=5 unlock_time=900') }
  its('content') { should include('auth        requisite     pam_succeed_if.so uid >= 1000 quiet_success') }
  its('content') { should include('auth        required      pam_deny.so') }
  its('content') { should include('auth        [success=1 default=bad] pam_unix.so') }
  its('content') { should include('auth        [default=die] pam_faillock.so authfail audit deny=5 unlock_time=900') }
  its('content') { should include('account     required      pam_unix.so') }
  its('content') { should include('account     sufficient    pam_localuser.so') }
  its('content') { should include('account     sufficient    pam_succeed_if.so uid < 1000 quiet') }
  its('content') { should include('account     required      pam_permit.so') }
  its('content') { should include('password    requisite     pam_pwquality.so try_first_pass local_users_only retry=3 authtok_type=') }
  its('content') { should include('password    sufficient    pam_unix.so sha512 shadow nullok try_first_pass use_authtok remember=5') }
  its('content') { should include('password    required      pam_deny.so') }
  its('content') { should include('session     optional      pam_keyinit.so revoke') }
  its('content') { should include('session     required      pam_limits.so') }
  its('content') { should include('-session     optional      pam_systemd.so') }
  its('content') { should include('session     [success=1 default=ignore] pam_succeed_if.so service in crond quiet use_uid') }
  its('content') { should include('session     required      pam_unix.so') }
end



describe file('/etc/pam.d/password-auth') do
  it { should be_file }
  it { should exist }
  it { should be_linked_to '/etc/pam.d/password-auth-ac' }
end
describe file('/etc/pam.d/password-auth-ac') do
  it { should be_file }
  it { should exist }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its('mode') { should cmp '0644' }
  its('content') { should include('auth        required      pam_env.so') }
  its('content') { should include('auth        required      pam_faillock.so preauth audit silent deny=5 unlock_time=900') }
  its('content') { should include('auth        sufficient    pam_unix.so nullok try_first_pass') }
  its('content') { should include('auth        sufficient    pam_faillock.so authsucc audit deny=5 unlock_time=900') }
  its('content') { should include('auth        requisite     pam_succeed_if.so uid >= 1000 quiet_success') }
  its('content') { should include('auth        required      pam_deny.so') }
  its('content') { should include('auth        [success=1 default=bad] pam_unix.so') }
  its('content') { should include('auth        [default=die] pam_faillock.so authfail audit deny=5 unlock_time=900') }
  its('content') { should include('account     required      pam_unix.so') }
  its('content') { should include('account     sufficient    pam_localuser.so') }
  its('content') { should include('account     sufficient    pam_succeed_if.so uid < 1000 quiet') }
  its('content') { should include('account     required      pam_permit.so') }
  its('content') { should include('password    requisite     pam_pwquality.so try_first_pass local_users_only retry=3 authtok_type=') }
  its('content') { should include('password    sufficient    pam_unix.so sha512 shadow nullok try_first_pass use_authtok remember=5') }
  its('content') { should include('password    required      pam_deny.so') }
  its('content') { should include('session     optional      pam_keyinit.so revoke') }
  its('content') { should include('session     required      pam_limits.so') }
  its('content') { should include('-session     optional      pam_systemd.so') }
  its('content') { should include('session     [success=1 default=ignore] pam_succeed_if.so service in crond quiet use_uid') }
  its('content') { should include('session     required      pam_unix.so') }
end
