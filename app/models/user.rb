class User < ActiveRecord::Base
  validates_presence_of :login, :email
  
  named_scope :customers, :conditions => "roles.name = 'customer'", :include => { :user_roles => :role }
  named_scope :field_managers, :conditions => "roles.name = 'field_manager'", :include => { :user_roles => :role }
  named_scope :operators, :conditions => "roles.name = 'operator'", :include => { :user_roles => :role }
  named_scope :emergencies, :conditions => "roles.name = 'emergencies'", :include => { :user_roles => :role }

  acts_as_authentic
  
  has_many :user_roles
  has_many :roles, :through => :user_roles
  
  has_one :person
  accepts_nested_attributes_for :person
  
  has_one :address
  accepts_nested_attributes_for :address
  
  has_many :user_regions
  has_many :regions, :through => :user_regions

  before_update :validate_password_fields

  def self.search_and_paginate(search = :all,page = 1, per_page = 10)
      User.search(search).all.paginate(:page => page, :per_page => per_page)
  end

  def validate_password_fields
    if self.password == nil
      self.errors.add_to_base("Password field can't be blank")
    end
  end
    
  def role_symbols
    roles.collect { |role| role.name.to_sym } 
  end

  def has_role?(role)
    role_symbols.include?(role)
  end

  def send_random_password
    new_password = User.random_password(10)
    self.password = self.password_confirmation = new_password
    self.save
    Notifier.queue(:random_password, self, new_password)
  end

  def region_id
    self.person.region.id
  end
  
  def mobile_phones
    unless address.nil?
      address.mobile_phone.gsub(/044/,'').strip.gsub(/\s/,'').split(',')
    else
      []
    end
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
