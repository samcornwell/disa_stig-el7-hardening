
describe file('/etc/audit') do
  it { should exist }
  it { should be_directory }
end

describe file('/etc/audit/auditd.conf') do
  it { should exist }
  it { should be_file }
  its('mode') { should cmp '0640' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its('content') { should include('log_file = /var/log/audit/audit.log') }
  its('content') { should include('log_format = RAW') }
  its('content') { should include('log_group = root') }
  its('content') { should include('priority_boost = 4') }
  its('content') { should include('flush = INCREMENTAL') }
  its('content') { should include('freq = 20') }
  its('content') { should include('num_logs = 5') }
  its('content') { should include('disp_qos =  lossy') }
  its('content') { should include('dispatcher = /sbin/audispd') }
  its('content') { should include('name_format = NONE') }
  its('content') { should include('max_log_file = 25') }
  its('content') { should include('max_log_file_action = keep_logs') }
  its('content') { should include('space_left = 75') }
  its('content') { should include('space_left_action = email') }
  its('content') { should include('action_mail_acct = root') }
  its('content') { should include('admin_space_left = 50') }
  its('content') { should include('admin_space_left_action = halt') }
  its('content') { should include('disk_full_action = SUSPEND') }
  its('content') { should include('disk_error_action = SUSPEND') }
  its('content') { should include('tcp_listen_queue = 5') }
  its('content') { should include('tcp_max_per_addr = 1') }
  its('content') { should include('tcp_client_ports = 1024-65535') }
  its('content') { should include('use_libwrap = yes') }
  its('content') { should include('tcp_client_max_idle = 0') }
  its('content') { should include('enable_krb5 = no') }
  its('content') { should include('krb5_principal = auditd') }
end
