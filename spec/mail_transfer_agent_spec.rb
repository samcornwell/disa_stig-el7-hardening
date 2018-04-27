require 'spec_helper'

describe 'stig::mail_transfer_agent CentOS 7.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.3.1611').converge('stig::mail_transfer_agent') }

  it 'creates /etc/postfix/main.cf' do
    expect(chef_run).to create_template('/etc/postfix/main.cf').with(
      source: 'etc_main.cf_rhel.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'excludes postfix service due to :nothing guard' do
    postfix_service = chef_run.service('postfix')
    expect(postfix_service).to do_nothing
  end
end

describe 'stig::mail_transfer_agent CentOS 6.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '6.9').converge('stig::mail_transfer_agent') }

  it 'creates /etc/postfix/main.cf' do
    expect(chef_run).to create_template('/etc/postfix/main.cf').with(
      source: 'etc_main.cf_rhel.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'excludes postfix service due to :nothing guard' do
    expect(chef_run).to_not start_service('postfix')
  end
end
