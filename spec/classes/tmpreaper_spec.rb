require 'spec_helper'

describe 'tmpreaper' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts.merge({
          :concat_basedir => '/foo',
        })
      end
      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('tmpreaper::install') }
      it { is_expected.to contain_class('tmpreaper::config') }

      if facts[:osfamily] == 'Debian' 
        it { is_expected.to contain_package('tmpreaper').with_name('tmpreaper') }
      end
      if facts[:osfamily] == 'RedHat' 
        it { is_expected.to contain_package('tmpreaper').with_name('tmpwatch') }
      end
    end
  end
end
