class Address < ActiveRecord::Base
  has_paper_trail
  
  belongs_to :country
  belongs_to :state
  belongs_to :city

  belongs_to :user
  
  belongs_to :modified_by, :class_name => 'User'
end
