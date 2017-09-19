
describe command('grep /dev/shm /etc/fstab | grep nodev') do
  its(:stdout) { should match /nodev/ }
end
describe command('mount | grep /dev/shm | grep nodev') do
  its(:stdout) { should match /nodev/ }
end

describe command('grep /dev/shm /etc/fstab | grep nosuid') do
  its(:stdout) { should match /nosuid/ }
end
describe command('mount | grep /dev/shm | grep nosuid') do
  its(:stdout) { should match /nosuid/ }
end

describe command('grep /dev/shm /etc/fstab | grep noexec') do
  its(:stdout) { should match /noexec/ }
end
describe command('mount | grep /dev/shm | grep noexec') do
  its(:stdout) { should match /noexec/ }
end

describe file('/dev/shm') do
  it { should be_mounted }
end

describe command('mount | grep /var/tmp') do
  its(:stdout) { should include('/var/tmp') }
end

# TODO: Deal with failing test
# describe file('mount | grep /var/tmp') do
#   it { should be_mounted }
#   it do
#     should be_mounted.only_with(
#       :device  => '/tmp',
#       :type    => 'none',
#       :options => {
#         :rw   => true,
#         :bind => true
#       }
#     )
#   end
# end
