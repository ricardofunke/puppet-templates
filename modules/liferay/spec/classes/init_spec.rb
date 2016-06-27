require 'spec_helper'
describe 'liferay' do

  context 'with defaults for all parameters' do
    it { should contain_class('liferay') }
  end
end
