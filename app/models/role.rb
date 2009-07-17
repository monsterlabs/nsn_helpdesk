class Role < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  
  acts_as_tree
  
  has_many :user_roles
  has_many :users, :through => :user_roles
end
