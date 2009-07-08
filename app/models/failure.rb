class Failure < ActiveRecord::Base
  add_controller_routes
  
  validates_presence_of :title
  validates_uniqueness_of :title
  
  default_scope :order => 'title ASC'
end
