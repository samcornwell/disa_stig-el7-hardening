require 'spec_helper'

describe 'stig::system_auth CentOS 7.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.3.1611').converge('stig::system_auth') }

  before do
    allow(File).to receive(:symlink?).with(anything).and_call_original
    allow(File).to receive(:symlink?).with('/etc/pam.d/system-auth').and_return(false)
    allow(File).to receive(:symlink?).with('/etc/pam.d/password-auth').and_return(false)
  end

  it 'creates /etc/pam.d/system-auth symlink' do
    link = chef_run.link('/etc/pam.d/system-auth')
    expect(link).to_not link_to('/etc/pam.d/system-auth-ac')
  end

  it 'creates a system-auth template' do
    expect(chef_run).to create_template('/etc/pam.d/system-auth')
  end

  it 'creates a paasword-auth template' do
    expect(chef_run).to create_template('/etc/pam.d/password-auth')
  end

  it 'creates /etc/pam.d/password-auth symlink' do
    link = chef_run.link('/etc/pam.d/password-auth')
    expect(link).to_not link_to('/etc/pam.d/password-auth')
  end

  it 'Does not create /etc/pam.d/common-password template' do
    pw_template = chef_run.template('/etc/pam.d/common-password')
    expect(pw_template).to do_nothing
  end
end

describe 'stig::system_auth CentOS 6.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.3.1611').converge('stig::system_auth') }

  before do
    allow(File).to receive(:symlink?).with(anything).and_call_original
    allow(File).to receive(:symlink?).with('/etc/pam.d/system-auth').and_return(false)
    allow(File).to receive(:symlink?).with('/etc/pam.d/password-auth').and_return(false)
  end

  it 'creates a paasword-auth template' do
    expect(chef_run).to create_template('/etc/pam.d/password-auth')
  end

  it 'creates a system-auth template' do
    expect(chef_run).to create_template('/etc/pam.d/system-auth')
  end

  it 'creates /etc/pam.d/system-auth symlink' do
    link = chef_run.link('/etc/pam.d/system-auth')
    expect(link).to_not link_to('/etc/pam.d/system-auth-ac')
  end

  it 'creates /etc/pam.d/password-auth symlink' do
    link = chef_run.link('/etc/pam.d/password-auth')
    expect(link).to_not link_to('/etc/pam.d/password-auth')
  end

  it 'Does not create /etc/pam.d/common-password template' do
    expect(chef_run).to_not create_template('/etc/pam.d/common-password').with(
      source: 'etc_pam.d_common-password.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end
end
