class User < ActiveRecord::Base
  validates_presence_of :login, :email

  acts_as_authentic
  using_access_control
  
  has_many :user_roles
  has_many :roles, :through => :user_roles
  has_one  :person
  accepts_nested_attributes_for :person
  has_one  :address
  accepts_nested_attributes_for :address
  
  def role_symbols
    roles.collect { |role| role.name.to_sym } 
  end
end
