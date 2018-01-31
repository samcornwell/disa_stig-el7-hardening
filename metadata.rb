name             'stig'
maintainer       'USGS WSI'
maintainer_email 'isuftin@usgs.gov'
license          'CPL-1.0'
description      'Installs/Configures CIS STIG benchmarks'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.6.11'
source_url		 'https://github.com/USGS-CIDA/stig'
issues_url		 'https://github.com/USGS-CIDA/stig/issues'

supports         'centos', '>= 6.6'
supports         'centos', '>= 7.1'
supports         'ubuntu'

chef_version '>= 12.0.0'

depends			 'logrotate'
depends			 'sysctl'
