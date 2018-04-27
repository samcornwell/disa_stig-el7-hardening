require 'spec_helper'

describe 'stig::auditd CentOS 7.x' do
  context 'template context' do
    let(:solo) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '7.3.1611')
    end

    let(:chef_run) do
      solo.converge('stig::auditd') do
        solo.resource_collection.insert(Chef::Resource::Service.new('auditd', solo.run_context))
      end
    end

    it 'creates a directory /etc/audit/' do
      expect(chef_run).to create_directory('/etc/audit/')
    end


    it 'creates a template /etc/audit/auditd.conf' do
      expect(chef_run).to create_template('/etc/audit/auditd.conf').with(
      user: 'root',
      group: 'root',
      mode: 0o640
      )
    end


  end
end

describe 'stig::auditd CentOS 6.x' do
  context 'template context' do
    let(:solo) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '6.9')
    end

    let(:chef_run) do
      solo.converge('stig::auditd') do
        solo.resource_collection.insert(Chef::Resource::Service.new('auditd', solo.run_context))
      end
    end

    it 'creates a directory /etc/audit/' do
      expect(chef_run).to create_directory('/etc/audit/')
    end

    it 'creates a template /etc/audit/auditd.conf' do
      expect(chef_run).to create_template('/etc/audit/auditd.conf').with(
      user: 'root',
      group: 'root',
      mode: 0o640
      )
    end

  end
end
