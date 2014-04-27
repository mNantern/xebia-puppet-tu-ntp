require 'spec_helper'
describe 'ntp' do


  ['AIX','Debian', 'RedHat','SuSE', 'FreeBSD', 'Archlinux', 'Gentoo'].each do |system|
    context "on #{system}" do
      let(:facts) {{ :osfamily => system }}
      it { should contain_class('ntp') }
      it { should contain_class('ntp::install').that_comes_before('Class[ntp::config]') }
      it { should contain_class('ntp::config').that_notifies('Class[ntp::service]') }
      it { should contain_class('ntp::service') }
    end
  end
end
