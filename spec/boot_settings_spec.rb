require 'spec_helper'

describe 'stig::boot_settings CentOS 7.x' do

  # let(:chef_run) do
  #   ChefSpec::SoloRunner.new do |node|
  #     node.normal['stig']['grub']['hashedpassword'] = 'hello'
  #   end.converge(described_recipe)
  # end
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.3.1611').converge('stig::boot_settings') }

  grub_file = "/boot/grub2/grub.cfg"

  before do
    stub_command("grep -q 'selinux=0' #{grub_file}").and_return(false)
    stub_command("grep -q 'enforcing=0' #{grub_file}").and_return(false)
    stub_command("grep -q 'password' #{grub_file}").and_return(false)
    stub_command("echo $(getenforce) | awk '{print tolower($0)}' | grep -q -E '(enforcing|disabled)'").and_return(false)
  end

  it 'creates /selinux/enforce template' do
    allow(File).to receive(:directory?).with(anything).and_call_original
    allow(File).to receive(:directory?).with('/selinux').and_return(true)
    expect(chef_run).to create_template('/selinux/enforce')
    .with(
      source: 'selinux_enforce.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'does not create /etc/grub.d/40_custom on CentOS' do
    custom_template = chef_run.template('/etc/grub.d/40_custom')
    expect(custom_template).to do_nothing
  end

  it 'Does not execute update-grub on CentOS' do
    exec_update_grub = chef_run.execute('update-grub')
    expect(exec_update_grub).to do_nothing
  end

  it 'Executes setenforce for selinux on RHEL' do
    expect(chef_run).to run_execute('setenforce 1')
  end

  it 'Does not execute Remove selinux=0 from /etc/grub.conf on CentOS 6.x' do
    expect(chef_run).to_not run_execute("sed -i 's/selinux=0//' #{grub_file}")
  end

  it 'Does not execute Remove enforcing=0 from /etc/grub.conf on CentOS 6.x' do
    expect(chef_run).to_not run_execute("sed -i 's/enforcing=0//' #{grub_file}")
  end

  it "Creates #{grub_file} file" do
    expect(chef_run).to create_file(grub_file).with(
      user:   'root',
      group:  'root',
      mode: '0o600'
    )
  end

  it 'creates /etc/selinux/config template' do
    expect(chef_run).to create_template('/etc/selinux/config').with(
      source: 'etc_selinux_config.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'creates a link with attributes' do
    expect(chef_run).to create_link('/etc/sysconfig/selinux').with(to: '/etc/selinux/config')
  end

  it 'removes a package named setroubleshoot' do
    expect(chef_run).to remove_package('setroubleshoot')
  end

  it 'removes a package named mcstrans' do
    expect(chef_run).to remove_package('mcstrans')
  end

  it 'Does not Add MD5 password to grub' do
    chef_run.node.normal['stig']['grub']['hashedpassword'] = 'hello'
    chef_run.converge('stig::boot_settings')
    expect(chef_run).to_not run_execute("sed -i '11i password --md5 hello' #{grub_file}")
  end

  it 'Does not execute Add password to grub' do
    expect(chef_run).to_not run_execute("sed -i '/password/d' #{grub_file}")
  end

  it 'creates a cookbook_file /etc/inittab' do
    expect(chef_run).to_not create_cookbook_file('/etc/inittab').with(
    source: 'etc_inittab'
    )
  end

  it 'Does not create /etc/sysconfig/init template' do
    expect(chef_run).to_not create_template('/etc/sysconfig/init')
  end
end

describe 'stig::boot_settings CentOS 6.x' do

  # let(:chef_run) do
  #   ChefSpec::SoloRunner.new do |node|
  #     node.normal['stig']['grub']['hashedpassword'] = 'hello'
  #   end.converge(described_recipe)
  # end
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '6.7').converge('stig::boot_settings') }
  grub_file = "/boot/grub/grub.conf"

  before do
    stub_command("grep -q 'hello' #{grub_file}").and_return(false)
    stub_command("grep -q 'password' #{grub_file}").and_return(true)
    stub_command("grep -q 'selinux=0' #{grub_file}").and_return(true)
    stub_command("grep -q 'enforcing=0' #{grub_file}").and_return(true)
    stub_command("echo $(getenforce) | awk '{print tolower($0)}' | grep -q -E '(enforcing|disabled)'").and_return(false)
  end

  it 'creates /selinux/enforce template' do
    allow(File).to receive(:directory?).with(anything).and_call_original
    allow(File).to receive(:directory?).with('/selinux').and_return(true)
    expect(chef_run).to create_template('/selinux/enforce')
    .with(
      source: 'selinux_enforce.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'creates /etc/sysconfig/init template' do
    expect(chef_run).to create_template('/etc/sysconfig/init').with(
      source: 'etc_sysconfig_init.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'does not create /etc/grub.d/40_custom on CentOS' do
    expect(chef_run).to_not create_template('/etc/grub.d/40_custom').with(
      source: 'etc_grubd_40_custom.erb'
    )
  end

  it 'Executes Remove selinux=0 from /etc/grub.conf' do
    expect(chef_run).to run_execute("sed -i 's/selinux=0//' #{grub_file}")
  end

  it 'Executes Remove enforcing=0 from /etc/grub.conf' do
    expect(chef_run).to run_execute("sed -i 's/enforcing=0//' #{grub_file}")
  end

  it 'Executes Add MD5 password to grub' do
    chef_run.node.normal['stig']['grub']['hashedpassword'] = 'hello'
    chef_run.converge('stig::boot_settings')
    expect(chef_run).to run_execute("sed -i '11i password --md5 hello' #{grub_file}")
  end

  it 'Does not execute update-grub on CentOS' do
    expect(chef_run).to_not run_execute('update-grub')
  end

  it 'Executes setenforce for selinux on RHEL' do
    expect(chef_run).to run_execute('setenforce 1')
  end

  it 'Executes Add password to grub' do
    expect(chef_run).to run_execute("sed -i '/password/d' #{grub_file}")
  end

  it 'creates a cookbook_file /etc/inittab' do
    expect(chef_run).to create_cookbook_file('/etc/inittab').with(
    source: 'etc_inittab'
    )
  end

  it 'Creates /boot/grub/grub.conf file' do
    expect(chef_run).to create_file('/boot/grub/grub.conf').with(
      user:   'root',
      group:  'root',
      mode: '0o600'
    )
  end

  it 'creates /etc/selinux/config template' do
    expect(chef_run).to create_template('/etc/selinux/config').with(
      source: 'etc_selinux_config.erb',
      owner: 'root',
      group: 'root',
      mode: 0o644
    )
  end

  it 'creates a link with attributes' do
    expect(chef_run).to create_link('/etc/sysconfig/selinux').with(to: '/etc/selinux/config')
  end

  it 'removes a package named setroubleshoot' do
    expect(chef_run).to remove_package('setroubleshoot')
  end

  it 'removes a package named mcstrans' do
    expect(chef_run).to remove_package('mcstrans')
  end
end
