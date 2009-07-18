require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
describe Failure do
  describe 'validations on create' do
    should_validate_presence_of :title
    #should_validate_uniqueness_of :title
  end

  describe 'validations on update' do
    should_validate_presence_of :title
    #should_validate_uniqueness_of :title
  end
end