# Cookbook Name:: stig
# Recipe:: yum_update
# Author: Ivan Suftin <isuftin@usgs.gov>
#
# Description: Configure boot settings

execute 'yum_update' do
  command 'yum update -y'
end
