require 'spec_helper'

describe 'stig::login_banner CentOS 7.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.3.1611').converge('stig::login_banner') }

  it 'creates /etc/motd file' do
    expect(chef_run).to create_template('/etc/motd').with(
      path: '/etc/motd',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'creates /etc/issue file' do
    expect(chef_run).to create_template('/etc/issue').with(
      path: '/etc/issue',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'creates /etc/issue.net file' do
    expect(chef_run).to create_template('/etc/issue.net').with(
      path: '/etc/issue.net',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end
end

describe 'stig::login_banner CentOS 6.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '6.9').converge('stig::login_banner') }

  it 'creates /etc/motd file' do
    expect(chef_run).to create_template('/etc/motd').with(
      path: '/etc/motd',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'creates /etc/issue file' do
    expect(chef_run).to create_template('/etc/issue').with(
      path: '/etc/issue',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'creates /etc/issue.net file' do
    expect(chef_run).to create_template('/etc/issue.net').with(
      path: '/etc/issue.net',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end
end
