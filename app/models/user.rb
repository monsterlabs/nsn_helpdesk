class User < ActiveRecord::Base
  validates_presence_of :login, :email

  acts_as_authentic
  
  has_one :person
  accepts_nested_attributes_for :person
end
