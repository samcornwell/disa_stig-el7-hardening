require 'spec_helper'

describe 'stig::sshd_config CentOS 7.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.3.1611').converge('stig::sshd_config') }
  let(:template) { chef_run.template('/etc/ssh/sshd_config') }

  it 'creates /etc/ssh/sshd_config template' do
    expect(chef_run).to create_template('/etc/ssh/sshd_config').with(
      source: 'etc_ssh_sshd_config.erb',
      owner: 'root',
      group: 'root',
      mode: 0o600
    )
    expect(template).to notify('service[sshd]').delayed
  end

  it 'sets sshd service' do
    sshd_service = chef_run.service('sshd')
    expect(sshd_service).to do_nothing
  end
end

describe 'stig::sshd_config CentOS 6.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '6.9').converge('stig::sshd_config') }
  let(:template) { chef_run.template('/etc/ssh/sshd_config') }

  it 'creates /etc/ssh/sshd_config template' do
    expect(chef_run).to create_template('/etc/ssh/sshd_config').with(
      source: 'etc_ssh_sshd_config.erb',
      owner: 'root',
      group: 'root',
      mode: 0o600
    )
    expect(template).to notify('service[sshd]').delayed
  end

  it 'sets sshd service' do
    sshd_service = chef_run.service('sshd')
    expect(sshd_service).to do_nothing
  end
end
