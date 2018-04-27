require 'spec_helper'

describe 'stig::su_restriction CentOS 7.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.3.1611').converge('stig::su_restriction') }

  it 'Creates file /etc/pam.d/su on RHEL using RHEL template' do
    expect(chef_run).to create_cookbook_file('/etc/pam.d/su').with(
    source: 'etc_pam_d_su_centos',
    user: 'root',
    group: 'root',
    mode: 0o644
    )
  end

  it 'Not creates file /etc/pam.d/su on Debian using debian-specific template' do
    # This is a hack. I don't think that RSpec/ChefSpec is supposed to pick up
    # on the identity in the main param. It should pick up the path. For some
    # reason, that's not the case here
    su_cookbook = chef_run.cookbook_file('/etc/pam.d/su for Debian')
    expect(su_cookbook).to do_nothing
  end

end

describe 'stig::su_restriction 6.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '6.9').converge('stig::su_restriction') }

  it 'Creates file /etc/pam.d/su on RHEL using RHEL template' do
    expect(chef_run).to create_cookbook_file('/etc/pam.d/su').with(
    source: 'etc_pam_d_su_centos',
    user: 'root',
    group: 'root',
    mode: 0o644
    )
  end

  it 'Not creates file /etc/pam.d/su on Debian using debian-specific template' do
    # This is a hack. I don't think that RSpec/ChefSpec is supposed to pick up
    # on the identity in the main param. It should pick up the path. For some
    # reason, that's not the case here
    expect(chef_run).to_not create_cookbook_file('/etc/pam.d/su for Debian').with(
      path: '/etc/pam.d/su',
      source: 'etc_pam_d_su_ubuntu',
      user: 'root',
      group: 'root',
      mode: 0o644
    )
  end

end
