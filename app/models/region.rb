class Region < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  
  default_scope :order => 'name ASC' 
  
  has_many :tickets
  has_many :user_regions
  has_many :users, :through => :user_regions
  has_many :links
end
