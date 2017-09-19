require 'spec_helper'

describe 'stig::aide CentOS 7.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.3.1611').converge('stig::aide') }

  before do
    stub_command('crontab -u root -l | grep aide').and_return(false)
  end

  # 1.3.1
  it 'installs the aide package' do
    expect(chef_run).to install_package('aide')
  end

  #This is only for Debian
  it 'runs aideinit' do
    exec_aideinit = chef_run.execute('aideinit')
    expect(exec_aideinit).to do_nothing
  end

  it 'should create /etc/aide.conf on RHEL hosts' do
    expect(chef_run).to create_template('/etc/aide.conf')\
      .with(user: 'root', group: 'root', mode: 0o600)
  end
  it 'should notify aide to initialize database for RHEL' do
    aide_config = chef_run.template('/etc/aide.conf')
    expect(aide_config).to notify('execute[init_aide]').to(:run).delayed
  end

  it 'should not execute init_aide by default for RHEL' do
    exec_init_aide = chef_run.execute('init_aide')
    expect(exec_init_aide).to do_nothing
  end

  # 1.3.2
  it 'checks for aide on a schedule' do
    expect(chef_run).to create_cron('aide_cron').with(
      command: '/usr/sbin/aide --check',
      minute: '0',
      hour: '5',
      day: '*',
      month: '*'
    )
  end

  it 'Does not create remote file on CentOS' do
    get_file = chef_run.remote_file('/var/lib/aide/aide.db')
    expect(get_file).to do_nothing
  end

end

describe 'stig::aide CentOS 6.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '6.7').converge('stig::aide') }

  before do
    stub_command('crontab -u root -l | grep aide').and_return(false)
  end

  # 1.3.1
  it 'installs the aide package' do
    expect(chef_run).to install_package('aide')
  end

  #This is only for Debian
  it 'runs aideinit' do
    expect(chef_run).to_not run_execute('aideinit').with(
      user: 'root',
      creates: '/var/lib/aide/aide.db.new'
    )
  end

  it 'should create /etc/aide.conf on RHEL hosts' do
    expect(chef_run).to create_template('/etc/aide.conf')\
      .with(user: 'root', group: 'root', mode: 0o600)
  end
  it 'should notify aide to initialize database for RHEL' do
    aide_config = chef_run.template('/etc/aide.conf')
    expect(aide_config).to notify('execute[init_aide]').to(:run).delayed
  end

  it 'should not execute init_aide by default for RHEL' do
    exec_init_aide = chef_run.execute('init_aide')
    expect(exec_init_aide).to do_nothing
  end

  # 1.3.2
  it 'checks for aide on a schedule' do
    expect(chef_run).to create_cron('aide_cron').with(
      command: '/usr/sbin/aide --check',
      minute: '0',
      hour: '5',
      day: '*',
      month: '*'
    )
  end

  it 'Does not create remote file on CentOS' do
    expect(chef_run).to_not create_remote_file('/var/lib/aide/aide.db').with(
      user: 'root',
      creates: '/var/lib/aide/aide.db'
    )
  end

end
