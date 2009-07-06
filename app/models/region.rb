class Region < ActiveRecord::Base
  add_controller_routes
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  default_scope :order => 'name ASC' 
end
