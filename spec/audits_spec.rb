require 'spec_helper'

describe 'stig::audits CentOS 7.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.3.1611').converge('stig::audits') }

  before do
    stub_command("test -n \"$(/bin/cat /etc/shadow | /bin/awk -F: '($2 == \"\" )')\"").and_return(true)
  end

  before do
    stub_command("test -n \"$(/bin/grep '^+' /etc/passwd)\"").and_return(true)
  end

  before do
    stub_command("test -n \"$(/bin/grep '^+' /etc/shadow)\"").and_return(true)
  end

  before do
    stub_command("test -n \"$(/bin/grep '^+' /etc/group)\"").and_return(true)
  end

  before do
    stub_command("test -n \"$(df --local -P | awk {'if (NR!=1) print $6'} | uniq | xargs -I '{}' find '{}' -xdev -type f -perm -0002)\"").and_return(true)
  end

  before do
    stub_command("test -n \"$(df --local -P | awk {'if (NR!=1) print $6'} | uniq | xargs -I '{}' find '{}' -xdev -nouser -nogroup -ls)\"").and_return(true)
  end

  before do
    stub_command("/bin/cat /etc/passwd | /bin/awk -F: '($3 == 0) { print $1 }' | grep -v \"root\"").and_return(true)
  end

  it 'checks for empty password fields' do
    expect(chef_run).to run_bash('no_empty_passwd_fields').with(
      user: 'root',
      code: "for user in $(/bin/cat /etc/shadow | /bin/awk -F: '($2 == \"\")' | cut -d':' -f1 $1);do /usr/bin/passwd -l $user;done"
    )
  end

  it 'no legacy + entries exist in /etc/passwd' do
    expect(chef_run).to run_bash('no legacy + entries exist in /etc/passwd').with(
      user: 'root',
      code: "sed -i '/^+/ d' /etc/passwd"
    )
  end

  it 'no legacy + entries exist in /etc/shadow' do
    expect(chef_run).to run_bash('no legacy + entries exist in /etc/shadow').with(
      user: 'root',
      code: "sed -i '/^+/ d' /etc/shadow"
    )
  end

  it 'no legacy + entries exist in /etc/group' do
    expect(chef_run).to run_bash('no legacy + entries exist in /etc/group').with(
      user: 'root',
      code: "sed -i '/^+/ d' /etc/group"
    )
  end

  it 'checks for world writable files' do
    expect(chef_run).to run_bash('remove_world_writable_flag_from_files').with(
      user: 'root',
      code: "for fn in $(df --local -P | awk {'if (NR!=1) print $6'} | uniq | xargs -I '{}' find '{}' -xdev -type f -perm -0002);do chmod o-w $fn;done"
    )
  end

  it 'checks for unowned files and directories' do
    expect(chef_run).to run_bash('find user and group orphaned files and directories').with(
      user: 'root',
      code: "for fn in $(df --local -P | awk {'if (NR!=1) print $6'} | uniq | xargs -I '{}' find '{}' -xdev -nouser -nogroup -ls | awk '{ printf $11\"\\n\" }'); do chown root:root $fn;done"
    )
  end

  it 'no UID 0 except root account exists' do
    expect(chef_run).to run_bash('no UID 0 except root account exists').with(
      user: 'root',
      code: "for acct in $(/bin/cat /etc/passwd | /bin/awk -F: '($3 == 0) { print $1 }' | grep -v \"root\"); do sed -i \"/^$acct:/ d\" /etc/passwd;done"
    )
  end
end

describe 'stig::audits CentOS 6.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '6.7').converge('stig::audits') }

  before do
    stub_command("test -n \"$(/bin/cat /etc/shadow | /bin/awk -F: '($2 == \"\" )')\"").and_return(true)
  end

  before do
    stub_command("test -n \"$(/bin/grep '^+' /etc/passwd)\"").and_return(true)
  end

  before do
    stub_command("test -n \"$(/bin/grep '^+' /etc/shadow)\"").and_return(true)
  end

  before do
    stub_command("test -n \"$(/bin/grep '^+' /etc/group)\"").and_return(true)
  end

  before do
    stub_command("test -n \"$(df --local -P | awk {'if (NR!=1) print $6'} | uniq | xargs -I '{}' find '{}' -xdev -type f -perm -0002)\"").and_return(true)
  end

  before do
    stub_command("test -n \"$(df --local -P | awk {'if (NR!=1) print $6'} | uniq | xargs -I '{}' find '{}' -xdev -nouser -nogroup -ls)\"").and_return(true)
  end

  before do
    stub_command("/bin/cat /etc/passwd | /bin/awk -F: '($3 == 0) { print $1 }' | grep -v \"root\"").and_return(true)
  end

  it 'checks for empty password fields' do
    expect(chef_run).to run_bash('no_empty_passwd_fields').with(
      user: 'root',
      code: "for user in $(/bin/cat /etc/shadow | /bin/awk -F: '($2 == \"\")' | cut -d':' -f1 $1);do /usr/bin/passwd -l $user;done"
    )
  end

  it 'no legacy + entries exist in /etc/passwd' do
    expect(chef_run).to run_bash('no legacy + entries exist in /etc/passwd').with(
      user: 'root',
      code: "sed -i '/^+/ d' /etc/passwd"
    )
  end

  it 'no legacy + entries exist in /etc/shadow' do
    expect(chef_run).to run_bash('no legacy + entries exist in /etc/shadow').with(
      user: 'root',
      code: "sed -i '/^+/ d' /etc/shadow"
    )
  end

  it 'no legacy + entries exist in /etc/group' do
    expect(chef_run).to run_bash('no legacy + entries exist in /etc/group').with(
      user: 'root',
      code: "sed -i '/^+/ d' /etc/group"
    )
  end

  it 'checks for world writable files' do
    expect(chef_run).to run_bash('remove_world_writable_flag_from_files').with(
      user: 'root',
      code: "for fn in $(df --local -P | awk {'if (NR!=1) print $6'} | uniq | xargs -I '{}' find '{}' -xdev -type f -perm -0002);do chmod o-w $fn;done"
    )
  end

  it 'checks for unowned files and directories' do
    expect(chef_run).to run_bash('find user and group orphaned files and directories').with(
      user: 'root',
      code: "for fn in $(df --local -P | awk {'if (NR!=1) print $6'} | uniq | xargs -I '{}' find '{}' -xdev -nouser -nogroup -ls | awk '{ printf $11\"\\n\" }'); do chown root:root $fn;done"
    )
  end

  it 'no UID 0 except root account exists' do
    expect(chef_run).to run_bash('no UID 0 except root account exists').with(
      user: 'root',
      code: "for acct in $(/bin/cat /etc/passwd | /bin/awk -F: '($3 == 0) { print $1 }' | grep -v \"root\"); do sed -i \"/^$acct:/ d\" /etc/passwd;done"
    )
  end
end
