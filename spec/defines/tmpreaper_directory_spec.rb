require 'spec_helper'

describe 'tmpreaper::directory' do
  let(:title) { 'unit test directory' }
  let(:precondition) do
    "class {'::tmpreaper':}"
  end
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts.merge({
        })
      end

      context 'when using a wrong ensure value' do
        let(:params) {{
          :ensure    => 'foo',
          :directory => '/tmp/',
          :rtag      => 'foo',
        }}

        it 'should fail' do
          expect { should contain_tmpreaper__directory('unit test directory')
          }.to raise_error(Puppet::Error, /\$ensure must be either.* got 'foo'/)
        end
      end

      context 'when missing directory' do
        let(:params) {{
          :ensure    => 'foo',
          :rtag      => 'foo',
        }}

        it 'should fail' do
          expect { should contain_tmpreaper__directory('unit test directory')
          }.to raise_error(Puppet::Error, /(expects a value for parameter 'directory')|(Must pass directory to)/)
        end
      end

      context 'when using a wrong directory value' do
        let(:params) {{
          :ensure    => 'foo',
          :directory => 'tmp/',
          :rtag      => 'foo',
        }}

        it 'should fail' do
          expect { should contain_tmpreaper__directory('unit test directory')
          }.to raise_error(Puppet::Error, /\$ensure must be either.* got 'foo'/)
        end
      end

      context 'when missing rtag' do
        let(:params) {{
          :ensure    => 'present',
          :directory => '/tmp',
        }}

        it 'should fail' do
          expect { should contain_tmpreaper__directory('unit test directory')
          }.to raise_error(Puppet::Error, /(expects a value for parameter 'rtag')|(Must pass rtag to)/)
        end
      end

      context 'all is ok' do
        let(:params) {{
          :ensure    => 'present',
          :directory => '/tmp',
          :rtag      => 'tmp',
        }}
        
        if facts[:osfamily] == 'Debian'
          cmd = 'tmpreaper'
        else
          cmd = 'tmpwatch'
        end

        it { should contain_cron('tmpreaper for /tmp on root').with({
          :ensure  => 'present',
          :command => "#{cmd} --showdeleted --mtime 1w /tmp 2>&1 | logger -t tmpreaper-tmp",
          :user    => 'root',
        })}
      end

    end
  end
end
