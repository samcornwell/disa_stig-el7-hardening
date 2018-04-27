require 'spec_helper'

describe 'stig::login_defs CentOS 7.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.3.1611').converge('stig::login_defs') }
  it 'creates /etc/login.defs template' do
    expect(chef_run).to create_template('/etc/login.defs').with(
      source: 'etc_login.defs.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end
end

describe 'stig::login_defs CentOS 6.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '6.9').converge('stig::login_defs') }
  it 'creates /etc/login.defs template' do
    expect(chef_run).to create_template('/etc/login.defs').with(
      source: 'etc_login.defs.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end
end
