class User < ActiveRecord::Base
  validates_presence_of :login, :email
  
  named_scope :customers, :conditions => "roles.name = 'customer'", :include => { :user_roles => :role }
  named_scope :field_managers, :conditions => "roles.name = 'field_manager'", :include => { :user_roles => :role }
  named_scope :operators, :conditions => "roles.name = 'operator'", :include => { :user_roles => :role }

  acts_as_authentic
  using_access_control
  
  has_many :user_roles
  has_many :roles, :through => :user_roles
  has_one  :person
  accepts_nested_attributes_for :person
  has_one  :address
  accepts_nested_attributes_for :address
  
  has_many :user_regions
  has_many :regions, :through => :user_regions
    
  def role_symbols
    roles.collect { |role| role.name.to_sym } 
  end
  
  def send_random_password
    new_password = User.random_password(10)
    self.password = self.password_confirmation = new_password
    self.save
    Notifier.deliver_random_password(self, new_password)
  end
  
  private
  
  def self.random_password(length)
    chars = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
    (0...length).map{ chars[rand(chars.size)] }.join
  end

  def self.field_managers_collection
    field_managers = User.field_managers.collect - User.field_managers.collect[0].to_a
  end
  
end
