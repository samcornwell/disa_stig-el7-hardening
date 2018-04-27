require 'spec_helper'

describe 'stig::auditd_rules CentOS 7.x' do
  context 'template context' do
    let(:solo) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '7.3.1611')
    end

    let(:chef_run) do
      solo.converge('stig::auditd_rules') do
        solo.resource_collection.insert(Chef::Resource::Service.new('auditd', solo.run_context))
      end
    end

    let(:template) { chef_run.template('/etc/audit/audit.rules') }

    it 'Creates template' do
      expect(chef_run).to create_template('/etc/audit/audit.rules').with(
        user: 'root',
        group: 'root',
        source: 'audit_rules.erb'
      )
    end

    it 'sends a notification to the auditd service' do
      expect(template).to notify('service[auditd]').to(:reload).immediately
    end
  end
end

describe 'stig::auditd_rules CentOS 6.x' do
  context 'template context' do
    let(:solo) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '6.9')
    end

    let(:chef_run) do
      solo.converge('stig::auditd_rules') do
        solo.resource_collection.insert(Chef::Resource::Service.new('auditd', solo.run_context))
      end
    end

    let(:template) { chef_run.template('/etc/audit/audit.rules') }

    it 'Creates template' do
      expect(chef_run).to create_template('/etc/audit/audit.rules').with(
        user: 'root',
        group: 'root',
        source: 'audit_rules.erb'
      )
    end

    it 'sends a notification to the auditd service' do
      expect(template).to notify('service[auditd]').to(:reload).immediately
    end

  end
end
