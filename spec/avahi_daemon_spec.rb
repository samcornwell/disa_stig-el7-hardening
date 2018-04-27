require 'spec_helper'

describe 'stig::avahi_daemon CentOS 7.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.3.1611').converge('stig::avahi_daemon') }


  before do
    stub_command("/sbin/chkconfig | grep 'avahi-daemon' | grep 'on'").and_return(true)
    stub_command("systemctl >/dev/null 2>&1 && /usr/bin/systemctl list-unit-files | grep -q 'avahi'").and_return(true)
    stub_command("systemctl >/dev/null 2>&1 && /usr/bin/systemctl is-enabled avahi-daemon | grep -q 'disabled'").and_return(false)
  end

  it 'installs the avahi package' do
    expect(chef_run).to remove_package('avahi')
  end

  it 'not install the avahi-daemon package' do
    yum_pkg = chef_run.package('avahi-daemon')
    expect(yum_pkg).to do_nothing
  end

  it 'Does not execute chkconfig to turn off avahi-daemon' do
    expect(chef_run).to_not run_execute('Disable avahi-daemon via chkconfig').with(
      user: 'root',
      command: '/sbin/chkconfig avahi-daemon off'
    )
  end

  it 'executes systemctl to turn off avahi-daemon' do
    expect(chef_run).to run_execute('Disable avahi-daemon via sysctl').with(
      user: 'root',
      command: '/usr/bin/systemctl disable avahi-daemon'
    )
  end
end

describe 'stig::avahi_daemon CentOS 6.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '6.9').converge('stig::avahi_daemon') }

  grep_avahi_daemon_cmd = "/sbin/chkconfig | grep 'avahi-daemon' | grep 'on'"
  grep_zeroconf = 'grep NOZEROCONF -i /etc/sysconfig/network'

  before do
    stub_command(grep_avahi_daemon_cmd).and_return(true)
    stub_command("systemctl >/dev/null 2>&1 && /usr/bin/systemctl list-unit-files | grep -q 'avahi'").and_return(false)
    stub_command("systemctl >/dev/null 2>&1 && /usr/bin/systemctl is-enabled avahi-daemon | grep -q 'disabled'").and_return(false)
  end

  before do
    stub_command(grep_zeroconf).and_return(false)
  end

  it 'installs the avahi package' do
    expect(chef_run).to remove_package('avahi')
  end

  it 'not install the avahi-daemon package' do
    expect(chef_run).to_not install_package('avahi-daemon')
  end

  it 'executes chkconfig to turn off avahi-daemon' do
    expect(chef_run).to run_execute('Disable avahi-daemon via chkconfig').with(
      user: 'root',
      command: '/sbin/chkconfig avahi-daemon off'
    )
  end

  it 'executes chkconfig to turn off avahi-daemon' do
    expect(chef_run).to_not run_execute('Disable avahi-daemon via sysctl').with(
      user: 'root',
      command: '/usr/bin/systemctl disable avahi-daemon'
    )
  end
end
