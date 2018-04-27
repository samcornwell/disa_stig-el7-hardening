require 'spec_helper'

describe 'stig::rsyslog CentOS 7.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.3.1611').converge('stig::rsyslog') }

  it 'creates /etc/rsyslog.conf template' do
    expect(chef_run).to create_template('/etc/rsyslog.conf').with(
      source: 'etc_rsyslog.conf.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'excludes restart_syslog execution due to :nothing guard' do
    exec_restart_syslog = chef_run.execute('restart_syslog')
    expect(exec_restart_syslog).to do_nothing
  end
end

describe 'stig::rsyslog CentOS 6.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '6.9').converge('stig::rsyslog') }

  it 'creates /etc/rsyslog.conf template' do
    expect(chef_run).to create_template('/etc/rsyslog.conf').with(
      source: 'etc_rsyslog.conf.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'excludes restart_syslog execution due to :nothing guard' do
    expect(chef_run).to_not run_execute('restart_syslog')
  end
end
