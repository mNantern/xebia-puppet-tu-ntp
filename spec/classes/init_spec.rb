require 'spec_helper'
describe 'ntp' do


  ['Debian', 'RedHat','SuSE', 'FreeBSD', 'Archlinux', 'Gentoo'].each do |system|
    context "on #{system}" do
      let(:facts) {{ :osfamily => system }}
      it { should contain_class('ntp') }
    end
  end
end
