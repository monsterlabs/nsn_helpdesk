require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
describe Person do
  describe 'validations on create' do
    should_validate_presence_of :firstname
  end

  describe 'validations on update' do
    should_validate_presence_of :firstname
  end
end