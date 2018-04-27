require 'spec_helper'

describe 'stig::file_permissions CentOS 7.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.3.1611').converge('stig::file_permissions') }

  it 'creates /etc/anacrontab template' do
    expect(chef_run).to create_file('/etc/anacrontab').with(
      owner: 'root',
      group: 'root',
      mode: 0o600
    )
  end

  it 'creates /etc/crontab template' do
    expect(chef_run).to create_file('/etc/crontab').with(
      owner: 'root',
      group: 'root',
      mode: 0o600
    )
  end

  it 'creates /etc/cron.hourly template' do
    expect(chef_run).to create_directory('/etc/cron.hourly').with(
      owner: 'root',
      group: 'root',
      mode: 0o600
    )
  end

  it 'creates /etc/cron.daily template' do
    expect(chef_run).to create_directory('/etc/cron.daily').with(
      owner: 'root',
      group: 'root',
      mode: 0o600
    )
  end

  it 'creates /etc/cron.weekly template' do
    expect(chef_run).to create_directory('/etc/cron.weekly').with(
      owner: 'root',
      group: 'root',
      mode: 0o600
    )
  end

  it 'creates /etc/cron.monthly template' do
    expect(chef_run).to create_directory('/etc/cron.monthly').with(
      owner: 'root',
      group: 'root',
      mode: 0o600
    )
  end

  it 'creates /etc/cron.d template' do
    expect(chef_run).to create_directory('/etc/cron.d').with(
      owner: 'root',
      group: 'root',
      mode: 0o600
    )
  end

  it 'creates /etc/at.deny template' do
    expect(chef_run).to delete_file('/etc/at.deny')
  end

  it 'creates /etc/at.allow template' do
    expect(chef_run).to create_file('/etc/at.allow')
  end

  it 'creates file at /etc/passwd' do
    expect(chef_run).to create_file('/etc/passwd').with(
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'creates file at /etc/group' do
    expect(chef_run).to create_file('/etc/group').with(
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'creates file at /etc/cron.allow' do
    expect(chef_run).to create_file('/etc/cron.allow').with(
      owner: 'root',
      group: 'root',
      mode: 0o600
    )
  end

  it 'deletes file at /etc/cron.deny' do
    expect(chef_run).to delete_file('/etc/cron.deny')
  end

  it 'Does not create file at /etc/shadow' do
    expect(chef_run).to create_file('/etc/shadow').with(
      owner: 'root',
      group: 'root',
      mode: 0o000
    )
  end

  it 'Does not create file at /etc/gshadow' do
    expect(chef_run).to create_file('/etc/gshadow').with(
      owner: 'root',
      group: 'root',
      mode: 0o000
    )
  end
end

describe 'stig::file_permissions CentOS 6.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '6.9').converge('stig::file_permissions') }

  it 'creates /etc/anacrontab template' do
    expect(chef_run).to create_file('/etc/anacrontab').with(
      owner: 'root',
      group: 'root',
      mode: 0o600
    )
  end

  it 'creates /etc/crontab template' do
    expect(chef_run).to create_file('/etc/crontab').with(
      owner: 'root',
      group: 'root',
      mode: 0o600
    )
  end

  it 'creates /etc/cron.hourly template' do
    expect(chef_run).to create_directory('/etc/cron.hourly').with(
      owner: 'root',
      group: 'root',
      mode: 0o600
    )
  end

  it 'creates /etc/cron.daily template' do
    expect(chef_run).to create_directory('/etc/cron.daily').with(
      owner: 'root',
      group: 'root',
      mode: 0o600
    )
  end

  it 'creates /etc/cron.weekly template' do
    expect(chef_run).to create_directory('/etc/cron.weekly').with(
      owner: 'root',
      group: 'root',
      mode: 0o600
    )
  end

  it 'creates /etc/cron.monthly template' do
    expect(chef_run).to create_directory('/etc/cron.monthly').with(
      owner: 'root',
      group: 'root',
      mode: 0o600
    )
  end

  it 'creates /etc/cron.d template' do
    expect(chef_run).to create_directory('/etc/cron.d').with(
      owner: 'root',
      group: 'root',
      mode: 0o600
    )
  end

  it 'creates /etc/at.deny template' do
    expect(chef_run).to delete_file('/etc/at.deny')
  end

  it 'creates /etc/at.allow template' do
    expect(chef_run).to create_file('/etc/at.allow')
  end

  it 'creates file at /etc/passwd' do
    expect(chef_run).to create_file('/etc/passwd').with(
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'creates file at /etc/group' do
    expect(chef_run).to create_file('/etc/group').with(
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'creates file at /etc/cron.allow' do
    expect(chef_run).to create_file('/etc/cron.allow').with(
      owner: 'root',
      group: 'root',
      mode: 0o600
    )
  end

  it 'deletes file at /etc/cron.deny' do
    expect(chef_run).to delete_file('/etc/cron.deny')
  end

  it 'Does not create file at /etc/shadow' do
    expect(chef_run).to create_file('/etc/shadow').with(
      owner: 'root',
      group: 'root',
      mode: 0o000
    )
  end

  it 'Does not create file at /etc/gshadow' do
    expect(chef_run).to create_file('/etc/gshadow').with(
      owner: 'root',
      group: 'root',
      mode: 0o000
    )
  end
end
