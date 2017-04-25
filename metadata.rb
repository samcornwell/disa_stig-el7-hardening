name             'stig'
maintainer       'USGS WSI'
maintainer_email 'isuftin@usgs.gov'
license          'GPL-3.0'
description      'Installs/Configures CIS STIG benchmarks'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.6.6'
source_url		 'https://github.com/USGS-CIDA/stig'
issues_url		 'https://github.com/USGS-CIDA/stig/issues'

supports         'centos', '>= 6.6'
supports         'centos', '>= 7.1'
supports         'ubuntu'

depends			 'logrotate'
depends			 'sysctl'

chef_version '~> 13.0.0' if respond_to?(:chef_version)
