require 'spec_helper'
describe 'ntp::config' do

  let(:pre_condition){
    'include ntp::params'
  }

  ['AIX','Debian', 'RedHat','SuSE', 'FreeBSD', 'Archlinux', 'Gentoo'].each do |system|
    let(:facts) {{ :osfamily => system }}

    context "on #{system}" do
      it do
        should contain_file('/etc/ntp.conf').with(
          'ensure'  => 'file',
          'owner'   => 0,
          'group'   => 0,
          'mode'    => '0644',
          'content' => /pool\.ntp\.org/
        )
      end
    end

    context "on #{system} with keys_enable" do
      hiera = Hiera.new(:config    => 'spec/fixtures/hiera/hiera.yaml')
      config = hiera.lookup("ntp_#{system}_conf",nil,nil)
      keys_file = config['keysfile']
      directory = File.dirname(keys_file)

      let (:params) {{:keys_enable =>  true, :keys_file => keys_file}}
      it do
        should contain_file(directory).with(
          'ensure'  => 'directory',
          'owner'   => 0,
          'group'   => 0,
          'mode'    => '0755',
          'recurse' => true
        )
      end
    end
  end
end
