require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
describe Region do
  describe 'validations on create' do
    should_validate_presence_of :name
  end

  describe 'validations on update' do
    should_validate_presence_of :name
  end
end