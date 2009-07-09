class Role < ActiveRecord::Base
  acts_as_tree
  has_many :user_roles
  has_many :users, :through => :user_roles
end
