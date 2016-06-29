require 'spec_helper'
describe 'databases' do

  context 'with defaults for all parameters' do
    it { should contain_class('databases') }
  end
end
