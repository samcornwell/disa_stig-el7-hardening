## Changelog
---------

- 0.6.11

-- [isuftin@usgs.gov] - Due to a change in the Chef client @ 13.7.16, the aide
recipe needed to be updated. Also updated Rubocop, Chefspec and Foodcritic issues

- 0.6.10

-- [jmorris@usgs.gov] - Added template for /etc/aide.conf and it updates the aide database
-- [jmorris@usgs.gov] - Added default attributes for Centos 6 & 7 for /etc/aide.conf
-- [jmorris@usgs.gov] - Added inspec and unit tests for /etc/aide.conf
-- [jmorris@usgs.gov] - Corrected inspec tests centos7 to run aide tests for redhat platforms

- 0.6.9

-- [isuftin@usgs.gov] - Updated more audit not included in the last version
-- [isuftin@usgs.gov] - Combined two audit steps into one to save time/processing

- 0.6.8

-- [isuftin@usgs.gov] - Updated audit scripts to not double-check file mounts that
may appear twice in df output

- 0.6.7

-- [jmorris@usgs.gov] - Updated defaults for audit.rules to avoid 32/64 bit syscall mismatch warning
-- [jmorris@usgs.gov] - Removed "redhat" from the test for purging the avahi-daemon package
-- [jmorris@usgs.gov] - Updated unit tests to work around errors
-- [jmorris@usgs.gov] - Updated style tests for later version of foodcritic/rubocop

- 0.6.6

-- [isuftin@usgs.gov] - Updating the cookbook to work properly with CentOS 7
-- [isuftin@usgs.gov] - Added disabling vfat and ipv6 to modprobe
-- [isuftin@usgs.gov] - Update avahi daemon recipe for CentOS 7 (chkconfig vs sysctl)
-- [isuftin@usgs.gov] - Update ipv6 recipe for CentOS 7
-- [isuftin@usgs.gov] - Fixed idempotency issue in ipv6 recipe for CentOS 6
-- [isuftin@usgs.gov] - Update dhcp recipe for CentOS 7
-- [isuftin@usgs.gov] - Update rsyslog.conf default attributes to the latest CIS recommendations
-- [isuftin@usgs.gov] - Update sshd_config template to put logic on keywords that may or may not exist in sshd
-- [isuftin@usgs.gov] - Switched system_auth recipe to use templates instead of very touchy sed/grep
-- [isuftin@usgs.gov] - Changed default PASS_MIN_DAYS in login_defs to 7 as per stig
-- [isuftin@usgs.gov] - Updated file_permissions recipe to not branch on ubuntu/rhel
-- [isuftin@usgs.gov] - Split InSpec tests into CentOS 6 and CentOS 7
-- [isuftin@usgs.gov] - Updated Gemfile to require a minimal inspec gem version

- 0.6.5

-- [isuftin@usgs.gov] - Leaving sysctl attribute mutation solely to the sysctl cookbook.
-- [isuftin@usgs.gov] - Removing STIG cookbook attributes for sysctl. Using only sysctl cookbook attributes

- 0.6.4

-- [isuftin@usgs.gov] - Update mail transfer agent recipe to fully parameterize the CentOS template for main.cf

- 0.6.3

-- [isuftin@usgs.gov] - Update the system_auth recipe to respect pre-existing symlinks
-- [isuftin@usgs.gov] - Fix boot_settings recipe to catch if selinux is disabled and move on

- 0.6.2

-- [isuftin@usgs.gov] - More testing
-- [isuftin@usgs.gov] - Updated auditd ruleset to include more rules
-- [isuftin@usgs.gov] - Created ChefSpec testing for auditd_rules recipe
-- [isuftin@usgs.gov] - Updated ServerSpec testing for all default auditd rules

- 0.6.1
-- [isuftin@usgs.gov] - More rubocop fixes
-- [isuftin@usgs.gov] - Rework of sshd_config recipe to allow more customization
-- [isuftin@usgs.gov] - Updated templates to point to proper GitHub URL
-- [isuftin@usgs.gov] - Updated dependency version for sysctl cookbook in Berksfile
-- [isuftin@usgs.gov] - Fixed kitchen converge warnings

- 0.6.0
-- [steve@bigsteve.us] - fix some rubocop violations
-- [steve@bigsteve.us] - switch to using chef inspec
-- [steve@bigsteve.us] - remove Centos 6.6 and 6.8  
-- [steve@bigsteve.us] - bump version to 0.6.0
-- [steve@bigsteve.us] - remove kitchen version pin.

- 0.5.5
-- [arothian@github] - Update aide to setup crontab for ubuntu

- 0.5.4
-- [isuftin@usgs.gov] - Fix an issue with auth-config being improperly written to for pass reuse limit

- 0.5.3
-- [isuftin@usgs.gov] - Switch sysctl write flags

- 0.5.2
-- [isuftin@usgs.gov] - Ignore errors on unknown sysctl keys

- 0.5.1
-- [isuftin@usgs.gov] - Included third-party sysctl cookbook as a hard-coupled dependency by calling it in proc_hard recipe

- 0.5.0
-- [isuftin@usgs.gov] - Switched sysctl.conf template writing out and brought in the third-party sysctl cookbook to handle writing .d config file
-- [isuftin@usgs.gov] - Updated serverspec testing

- 0.4.3
-- [isuftin@usgs.gov] - Updated to switch out which file in /etc/pam.d/system-auth* gets symlinked

- 0.4.2
-- [isuftin@usgs.gov] - Fix most foodcritic errors and warnings
-- [isuftin@usgs.gov] - CIS 1.6.2 (Configure ExecShield) was removed in 2.0.0 of all CIS STIG. No longer testing for it
-- [isuftin@usgs.gov] - Added updates to SSHD config to allow boolean for password authentication
-- [isuftin@usgs.gov] - Updated system auth recipe to be less destructive to /etc/pam.d/system-auth since that may be updated by authconfig
-- [isuftin@usgs.gov] - Fixed a few tests


- 0.4.1
-- [isuftin@usgs.gov] - Updated sshd config to include approved ciphers (RHEL6 STIG 6.2.11)
-- [isuftin@usgs.gov] - Added the ability to change `ChallengeResponseAuthentication` in sshd config
-- [isuftin@usgs.gov] - Added the ability to change `UsePAM` in sshd config

- 0.4.0
-- [isuftin@usgs.gov] - Users may now add auditd rules directly as a series of attributes

- 0.3.11
-- [isuftin@usgs.gov] - More Auditd fixes

- 0.3.10
-- [isuftin@usgs.gov] - Fix auditd default parameters which break the build
-- [isuftin@usgs.gov] - Add documentation for new attributes

- 0.3.9
-- [isuftin@usgs.gov] - Fully parameterized auditd configuration file
-- [isuftin@usgs.gov] - No longer calling the auditd cookbook directly from auditd.rb
-- [isuftin@usgs.gov] - Auditd cookbook is no longer a direct dependency of the STIG cookbook. Should be part of an overall runlist

- 0.3.8
-- [isuftin@usgs.gov] - Updated STIG and Audit rules to CIS RHEL Stig 1.4.0
-- [isuftin@usgs.gov] - Added CentOS 6 ruleset 3.2 - "Remove the X Window System"
-- [isuftin@usgs.gov] - Fixed and added many Serverspec tests
-- [isuftin@usgs.gov] - Corrected a typo in `check_duplicate_gid.sh` to correct STIG control number
-- [isuftin@usgs.gov] - Removed CIS wording from audit scripts
-- [isuftin@usgs.gov] - Enforced permissions on /boot/grub/grub.conf as per STIG 1.5.2
-- [isuftin@usgs.gov] - Removed grub.conf template
-- [isuftin@usgs.gov] - Updated mounting of /dev/shm to be idempotent
