
describe file('/root/.audit') do
  it { should be_directory }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its('mode') { should cmp '0600' }
end

describe file('/root/.audit/find_suid_system_executables.sh') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_executable }
  its('mode') { should cmp '0700' }
end

describe file('/root/.audit/find_sgid_system_executables.sh') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_executable }
  its('mode') { should cmp '0700' }
end

describe file('/root/.audit/path_integrity_check.sh') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_executable }
  its('mode') { should cmp '0700' }
end

describe file('/root/.audit/rhosts_check.sh') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_executable }
  its('mode') { should cmp '0700' }
end

describe file('/root/.audit/check_groups_in_etc_passwd.sh') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_executable }
  its('mode') { should cmp '0700' }
end

describe file('/root/.audit/validate_users_homedirs.sh') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_executable }
  its('mode') { should cmp '0700' }
end

describe file('/root/.audit/check_duplicate_uid.sh') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_executable }
  its('mode') { should cmp '0700' }
end

describe file('/root/.audit/check_duplicate_gid.sh') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_executable }
  its('mode') { should cmp '0700' }
end

describe file('/root/.audit/check_duplicate_usernames.sh') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_executable }
  its('mode') { should cmp '0700' }
end

describe file('/root/.audit/check_duplicate_groupnames.sh') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_executable }
  its('mode') { should cmp '0700' }
end
