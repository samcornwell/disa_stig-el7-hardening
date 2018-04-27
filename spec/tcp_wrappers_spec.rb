require 'spec_helper'

describe 'stig::tcp_wrappers CentOS 7.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.3.1611').converge('stig::tcp_wrappers') }

  it 'installs tcp_wrappers package' do
    expect(chef_run).to install_package('tcp_wrappers')
  end

end

describe 'stig::tcp_wrappers CentOS 6.x' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '6.9').converge('stig::tcp_wrappers') }

  it 'installs tcp_wrappers package' do
    expect(chef_run).to install_package('tcp_wrappers')
  end

end
