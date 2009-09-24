class Status < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  
  has_many :tickets
  
  default_scope :order => 'name ASC'
end
