require 'spec_helper_acceptance'

describe 'tmpreaper' do
  context 'with defaults' do
    it 'should apply without error' do
      pp = <<-EOS
        class { 'tmpreaper': }
      EOS

      apply_manifest(pp, :catch_failures => true)
    end
    it 'should idempotently run' do
      pp = <<-EOS
        class { 'tmpreaper': }
      EOS

      apply_manifest(pp, :catch_changes => true)
    end
  end
end
