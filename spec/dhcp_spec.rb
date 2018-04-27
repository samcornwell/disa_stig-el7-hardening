require 'spec_helper'

describe 'stig::dhcp CentOS 7.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.3.1611').converge('stig::dhcp') }

  before do
    stub_command("systemctl >/dev/null 2>&1 && /usr/bin/systemctl list-unit-files | grep -q 'dhcpd'").and_return(true)
    stub_command("systemctl >/dev/null 2>&1 && /usr/bin/systemctl is-enabled dhcpd | grep -q 'disabled'").and_return(false)
  end

  it 'removes DHCP' do
    expect(chef_run).to remove_rpm_package('dhcp')
  end

  it 'does not create /etc/init/isc-dhcp-server.conf template on CentOS' do
    dhcp_template = chef_run.template('/etc/init/isc-dhcp-server.conf')
    expect(dhcp_template).to do_nothing
  end

  it 'does not create /etc/init/isc-dhcp-server6.conf template on CentOS' do
    dhcp6_template = chef_run.template('/etc/init/isc-dhcp-server6.conf')
    expect(dhcp6_template).to do_nothing
  end

  it 'Disable dhcpd via sysctl' do
    expect(chef_run).to run_execute('Disable dhcpd via sysctl').with(
      user: 'root',
      command: '/usr/bin/systemctl disable dhcpd'
    )
  end

end

describe 'stig::dhcp CentOS 6.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '6.9').converge('stig::dhcp') }

  before do
    stub_command("systemctl >/dev/null 2>&1 && /usr/bin/systemctl list-unit-files | grep -q 'dhcpd'").and_return(true)
    stub_command("systemctl >/dev/null 2>&1 && /usr/bin/systemctl is-enabled dhcpd | grep -q 'disabled'").and_return(false)
  end

  it 'removes DHCP' do
    expect(chef_run).to remove_rpm_package('dhcp')
  end

  it 'does not create /etc/init/isc-dhcp-server.conf template on CentOS' do
    expect(chef_run).to_not create_template('/etc/init/isc-dhcp-server.conf')
    .with(
      source: 'etc_init_isc-dhcp-server.conf.erb',
      owner: 'root',
      group: 'root'
    )
  end

  it 'does not create /etc/init/isc-dhcp-server6.conf template on CentOS' do
    expect(chef_run).to_not create_template('/etc/init/isc-dhcp-server6.conf')
    .with(
      source: 'etc_init_isc-dhcp-server6.conf.erb',
      owner: 'root',
      group: 'root'
    )
  end
end
