require 'spec_helper'

describe 'stig::proc_hard CentOS 7.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.3.1611').converge('stig::proc_hard') }

  before do
    stub_command('sysctl -n -e fs.suid_dumpable').and_return(true)
    stub_command('sysctl -n -e net.ipv4.ip_forward').and_return(true)
    stub_command('sysctl -n -e net.ipv4.conf.all.send_redirects').and_return(true)
    stub_command('sysctl -n -e net.ipv4.conf.default.send_redirects').and_return(true)
    stub_command('sysctl -n -e net.ipv4.conf.all.accept_redirects').and_return(true)
    stub_command('sysctl -n -e net.ipv4.conf.default.accept_redirects').and_return(true)
    stub_command('sysctl -n -e net.ipv4.conf.all.log_martians').and_return(true)
    stub_command('sysctl -n -e net.ipv4.conf.default.log_martians').and_return(true)
    stub_command('sysctl -n -e net.ipv4.conf.all.rp_filter').and_return(true)
    stub_command('sysctl -n -e net.ipv4.conf.default.rp_filter').and_return(true)
    stub_command('sysctl -n -e net.ipv6.conf.all.accept_redirects').and_return(true)
    stub_command('sysctl -n -e net.ipv6.conf.default.accept_redirects').and_return(true)
    stub_command('sysctl -n -e net.ipv4.conf.all.secure_redirects').and_return(true)
    stub_command('sysctl -n -e net.ipv4.conf.default.secure_redirects').and_return(true)
    stub_command('sysctl -n -e net.ipv6.conf.all.accept_ra').and_return(true)
    stub_command('sysctl -n -e net.ipv6.conf.default.accept_ra').and_return(true)
    stub_command('sysctl -n -e net.ipv6.route.flush').and_return(true)
    stub_command('sysctl -n -e net.ipv6.conf.all.disable_ipv6').and_return(true)
    stub_command('sysctl -n -e net.ipv6.conf.default.disable_ipv6').and_return(true)
    stub_command('sysctl -n -e net.ipv6.conf.lo.disable_ipv6').and_return(true)
  end

  it 'creates /etc/security/limits.conf template' do
    expect(chef_run).to create_template('/etc/security/limits.conf').with(
      source: 'limits.conf.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'does not remove apport package on RHEL' do
    yum_pkg = chef_run.package('apport')
    expect(yum_pkg).to do_nothing
  end

  it 'does not remove whoopsie package on RHEL' do
    yum_pkg = chef_run.package('whoopsie')
    expect(yum_pkg).to do_nothing
  end
end

describe 'stig::proc_hard CentOS 6.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '6.9').converge('stig::proc_hard') }

  before do
    stub_command('sysctl -n -e fs.suid_dumpable').and_return(true)
    stub_command('sysctl -n -e net.ipv4.ip_forward').and_return(true)
    stub_command('sysctl -n -e net.ipv4.conf.all.send_redirects').and_return(true)
    stub_command('sysctl -n -e net.ipv4.conf.default.send_redirects').and_return(true)
    stub_command('sysctl -n -e net.ipv4.conf.all.accept_redirects').and_return(true)
    stub_command('sysctl -n -e net.ipv4.conf.default.accept_redirects').and_return(true)
    stub_command('sysctl -n -e net.ipv4.conf.all.log_martians').and_return(true)
    stub_command('sysctl -n -e net.ipv4.conf.default.log_martians').and_return(true)
    stub_command('sysctl -n -e net.ipv4.conf.all.rp_filter').and_return(true)
    stub_command('sysctl -n -e net.ipv4.conf.default.rp_filter').and_return(true)
    stub_command('sysctl -n -e net.ipv6.conf.all.accept_redirects').and_return(true)
    stub_command('sysctl -n -e net.ipv6.conf.default.accept_redirects').and_return(true)
    stub_command('sysctl -n -e net.ipv4.conf.all.secure_redirects').and_return(true)
    stub_command('sysctl -n -e net.ipv4.conf.default.secure_redirects').and_return(true)
    stub_command('sysctl -n -e net.ipv6.conf.all.accept_ra').and_return(true)
    stub_command('sysctl -n -e net.ipv6.conf.default.accept_ra').and_return(true)
    stub_command('sysctl -n -e net.ipv6.route.flush').and_return(true)
    stub_command('sysctl -n -e net.ipv6.conf.all.disable_ipv6').and_return(true)
    stub_command('sysctl -n -e net.ipv6.conf.default.disable_ipv6').and_return(true)
    stub_command('sysctl -n -e net.ipv6.conf.lo.disable_ipv6').and_return(true)
  end

  it 'creates /etc/security/limits.conf template' do
    expect(chef_run).to create_template('/etc/security/limits.conf').with(
      source: 'limits.conf.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'does not remove apport package on RHEL' do
    expect(chef_run).to_not remove_package('apport')
  end

  it 'does not remove whoopsie package on RHEL' do
    expect(chef_run).to_not remove_package('whoopsie')
  end
end
