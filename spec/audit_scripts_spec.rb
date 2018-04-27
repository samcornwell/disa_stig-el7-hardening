require 'spec_helper'

describe 'stig::audit_scripts CentOS 7.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.3.1611').converge('stig::audit_scripts') }

  it 'creates an .audit sub directory in /root' do
    expect(chef_run).to create_directory('/root/.audit').with(
      owner: 'root',
      group: 'root',
      mode: 0o600
    )
  end

  it 'creates /root/.audit/find_suid_system_executables.sh file' do
    expect(chef_run).to create_cookbook_file('find_suid_system_executables.sh').with(
      path: '/root/.audit/find_suid_system_executables.sh',
      owner: 'root',
      group: 'root',
      mode: 0o700
    )
  end

  it 'creates /root/.audit/find_sgid_system_executables.sh file' do
    expect(chef_run).to create_cookbook_file('find_sgid_system_executables.sh').with(
      path: '/root/.audit/find_sgid_system_executables.sh',
      owner: 'root',
      group: 'root',
      mode: 0o700
    )
  end

  it 'creates /root/.audit/path_integrity_check.sh file' do
    expect(chef_run).to create_cookbook_file('path_integrity_check.sh').with(
      path: '/root/.audit/path_integrity_check.sh',
      owner: 'root',
      group: 'root',
      mode: 0o700
    )
  end

  it 'creates /root/.audit/rhosts_check.sh file' do
    expect(chef_run).to create_cookbook_file('rhosts_check.sh').with(
      path: '/root/.audit/rhosts_check.sh',
      owner: 'root',
      group: 'root',
      mode: 0o700
    )
  end

  it 'creates /root/.audit/check_groups_in_etc_passwd.sh file' do
    expect(chef_run).to create_cookbook_file('check_groups_in_etc_passwd.sh').with(
      path: '/root/.audit/check_groups_in_etc_passwd.sh',
      owner: 'root',
      group: 'root',
      mode: 0o700
    )
  end

  it 'creates /root/.audit/validate_users_homedirs.sh file' do
    expect(chef_run).to create_cookbook_file('validate_users_homedirs.sh').with(
      path: '/root/.audit/validate_users_homedirs.sh',
      owner: 'root',
      group: 'root',
      mode: 0o700
    )
  end

  it 'creates /root/.audit/check_duplicate_uid.sh file' do
    expect(chef_run).to create_cookbook_file('check_duplicate_uid.sh').with(
      path: '/root/.audit/check_duplicate_uid.sh',
      owner: 'root',
      group: 'root',
      mode: 0o700
    )
  end

  it 'creates /root/.audit/check_duplicate_gid.sh file' do
    expect(chef_run).to create_cookbook_file('check_duplicate_gid.sh').with(
      path: '/root/.audit/check_duplicate_gid.sh',
      owner: 'root',
      group: 'root',
      mode: 0o700
    )
  end

  it 'creates /root/.audit/check_duplicate_usernames.sh file' do
    expect(chef_run).to create_cookbook_file('check_duplicate_usernames.sh').with(
      path: '/root/.audit/check_duplicate_usernames.sh',
      owner: 'root',
      group: 'root',
      mode: 0o700
    )
  end

  it 'creates /root/.audit/check_duplicate_groupnames.sh file' do
    expect(chef_run).to create_cookbook_file('check_duplicate_groupnames.sh').with(
      path: '/root/.audit/check_duplicate_groupnames.sh',
      owner: 'root',
      group: 'root',
      mode: 0o700
    )
  end
end

describe 'stig::audit_scripts CentOS 6.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '6.9').converge('stig::audit_scripts') }

  it 'creates an .audit sub directory in /root' do
    expect(chef_run).to create_directory('/root/.audit').with(
      owner: 'root',
      group: 'root',
      mode: 0o600
    )
  end

  it 'creates /root/.audit/find_suid_system_executables.sh file' do
    expect(chef_run).to create_cookbook_file('find_suid_system_executables.sh').with(
      path: '/root/.audit/find_suid_system_executables.sh',
      owner: 'root',
      group: 'root',
      mode: 0o700
    )
  end

  it 'creates /root/.audit/find_sgid_system_executables.sh file' do
    expect(chef_run).to create_cookbook_file('find_sgid_system_executables.sh').with(
      path: '/root/.audit/find_sgid_system_executables.sh',
      owner: 'root',
      group: 'root',
      mode: 0o700
    )
  end

  it 'creates /root/.audit/path_integrity_check.sh file' do
    expect(chef_run).to create_cookbook_file('path_integrity_check.sh').with(
      path: '/root/.audit/path_integrity_check.sh',
      owner: 'root',
      group: 'root',
      mode: 0o700
    )
  end

  it 'creates /root/.audit/rhosts_check.sh file' do
    expect(chef_run).to create_cookbook_file('rhosts_check.sh').with(
      path: '/root/.audit/rhosts_check.sh',
      owner: 'root',
      group: 'root',
      mode: 0o700
    )
  end

  it 'creates /root/.audit/check_groups_in_etc_passwd.sh file' do
    expect(chef_run).to create_cookbook_file('check_groups_in_etc_passwd.sh').with(
      path: '/root/.audit/check_groups_in_etc_passwd.sh',
      owner: 'root',
      group: 'root',
      mode: 0o700
    )
  end

  it 'creates /root/.audit/validate_users_homedirs.sh file' do
    expect(chef_run).to create_cookbook_file('validate_users_homedirs.sh').with(
      path: '/root/.audit/validate_users_homedirs.sh',
      owner: 'root',
      group: 'root',
      mode: 0o700
    )
  end

  it 'creates /root/.audit/check_duplicate_uid.sh file' do
    expect(chef_run).to create_cookbook_file('check_duplicate_uid.sh').with(
      path: '/root/.audit/check_duplicate_uid.sh',
      owner: 'root',
      group: 'root',
      mode: 0o700
    )
  end

  it 'creates /root/.audit/check_duplicate_gid.sh file' do
    expect(chef_run).to create_cookbook_file('check_duplicate_gid.sh').with(
      path: '/root/.audit/check_duplicate_gid.sh',
      owner: 'root',
      group: 'root',
      mode: 0o700
    )
  end

  it 'creates /root/.audit/check_duplicate_usernames.sh file' do
    expect(chef_run).to create_cookbook_file('check_duplicate_usernames.sh').with(
      path: '/root/.audit/check_duplicate_usernames.sh',
      owner: 'root',
      group: 'root',
      mode: 0o700
    )
  end

  it 'creates /root/.audit/check_duplicate_groupnames.sh file' do
    expect(chef_run).to create_cookbook_file('check_duplicate_groupnames.sh').with(
      path: '/root/.audit/check_duplicate_groupnames.sh',
      owner: 'root',
      group: 'root',
      mode: 0o700
    )
  end
end
