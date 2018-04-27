require 'spec_helper'

describe 'stig::fstab_tmp CentOS 7.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.3.1611').converge('stig::fstab_tmp') }

  before do
    stub_command('mount | grep /var/tmp').and_return(false)
  end

  # 1.1.2, 1.1.3, 1.1.4
  it 'sets the nodev and nosuid option for /tmp partition' do
    expect(chef_run).to mount_mount('/dev/shm').with(
      options: %w(nodev nosuid noexec)
    )
  end

  # 1.1.6
  it 'binds /tmp to /var/tmp' do
    expect(chef_run).to mount_mount('/var/tmp').with(
      device: '/tmp',
      fstype: 'tmpfs',
      options: ['bind']
    )
  end

  it 'Does not mount at /run/shm on RHEL' do
    mountp = chef_run.mount('/run/shm')
    expect(mountp).to do_nothing
  end

  it 'Does not execute remount of /run/shm on RHEL' do
    exec_remount = chef_run.execute('mount -o remount /run/shm')
    expect(exec_remount).to do_nothing
  end
end

describe 'stig::fstab_tmp CentOS 6.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '6.9').converge('stig::fstab_tmp') }

  before do
    stub_command('mount | grep /var/tmp').and_return(false)
  end

  # 1.1.2, 1.1.3, 1.1.4
  it 'sets the nodev and nosuid option for /tmp partition' do
    expect(chef_run).to mount_mount('/dev/shm').with(
      options: %w(nodev nosuid noexec)
    )
  end

  # 1.1.6
  it 'binds /tmp to /var/tmp' do
    expect(chef_run).to mount_mount('/var/tmp').with(
      device: '/tmp',
      fstype: 'tmpfs',
      options: ['bind']
    )
  end

  it 'Does not mount at /run/shm on RHEL' do
    expect(chef_run).to_not mount_mount('/run/shm')
  end

  it 'Does not execute remount of /run/shm on RHEL' do
    expect(chef_run).to_not run_execute("mount -o remount /run/shm")
  end
end
