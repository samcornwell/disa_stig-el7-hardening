require 'spec_helper'

describe 'stig::ipv6 CentOS 7.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.3.1611').converge('stig::ipv6') }

  before do
    stub_command("systemctl list-unit-files iptables.service | grep -q -w enabled").and_return(false)
    stub_command("systemctl list-unit-files ip6tables.service | grep -q -w enabled").and_return(false)
    stub_command("systemctl is-active iptables.service | grep -q -w active").and_return(false)
    stub_command("systemctl is-active ip6tables.service | grep -q -w active").and_return(false)
  end

  it 'installs iptables-services' do
    expect(chef_run).to install_package('iptables-services')
  end

  it 'creates /etc/sysconfig/network template' do
    expect(chef_run).to create_template('/etc/sysconfig/network').with(
      source: 'etc_sysconfig_network.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'creates /etc/sysconfig/network template' do
    expect(chef_run).to create_template('/etc/sysconfig/network').with(
      source: 'etc_sysconfig_network.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'creates /etc/modprobe.d/ipv6.conf template' do
    expect(chef_run).to create_template('/etc/modprobe.d/ipv6.conf').with(
      source: 'etc_modprobe.d_ipv6.conf.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'Does not execute chkconfig_ip6tables_off' do
    expect(chef_run).to_not run_execute("/sbin/chkconfig ip6tables off")
  end

  it 'Executes enable_iptables' do
    expect(chef_run).to run_execute("systemctl enable iptables")
  end

  it 'Executes enable_ip6tables' do
    expect(chef_run).to run_execute("systemctl enable ip6tables")
  end

  it 'Executes start_iptables' do
    expect(chef_run).to start_service("iptables")
  end

  it 'Executes start_ip6tables' do
    expect(chef_run).to_not start_service("ip6tables")
  end
end

describe 'stig::ipv6 CentOS 6.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '6.7').converge('stig::ipv6') }

  before do
    stub_command("chkconfig --list ip6tables  | grep -q '2:off'").and_return(false)
    stub_command("chkconfig --list ip6tables  | grep -q '3:off'").and_return(false)
    stub_command("chkconfig --list ip6tables  | grep -q '4:off'").and_return(false)
    stub_command("chkconfig --list ip6tables  | grep -q '5:off'").and_return(false)
  end

  it 'creates /etc/sysconfig/network template' do
    expect(chef_run).to create_template('/etc/sysconfig/network').with(
      source: 'etc_sysconfig_network.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'creates /etc/sysconfig/network template' do
    expect(chef_run).to create_template('/etc/sysconfig/network').with(
      source: 'etc_sysconfig_network.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'creates /etc/modprobe.d/ipv6.conf template' do
    expect(chef_run).to create_template('/etc/modprobe.d/ipv6.conf').with(
      source: 'etc_modprobe.d_ipv6.conf.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'Does not execute chkconfig_ip6tables_off' do
    expect(chef_run).to run_execute("/sbin/chkconfig ip6tables off")
  end

end
