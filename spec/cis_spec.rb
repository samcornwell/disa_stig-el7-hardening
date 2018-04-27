require 'spec_helper'

describe 'stig::cis CentOS 7.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.3.1611').converge('stig::cis') }

  it 'creates /etc/modprobe.d/CIS.conf' do
    expect(chef_run).to create_template('/etc/modprobe.d/CIS.conf').with(
      source: 'etc_modprobe.d_CIS.conf.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end
end

describe 'stig::cis CentOS 6.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '6.9').converge('stig::cis') }

  it 'creates /etc/modprobe.d/CIS.conf' do
    expect(chef_run).to create_template('/etc/modprobe.d/CIS.conf').with(
      source: 'etc_modprobe.d_CIS.conf.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end
end
