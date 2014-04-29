require 'spec_helper'
describe 'ntp::config' do

  let(:pre_condition){
    'include ntp::params'
  }

  ['AIX','Debian', 'RedHat','SuSE', 'FreeBSD', 'Archlinux', 'Gentoo'].each do |system|
    context "on #{system}" do
      let(:facts) {{ :osfamily => system }}
      it { should contain_file('/etc/ntp.conf') }
    end
  end
end
