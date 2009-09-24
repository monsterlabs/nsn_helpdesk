class City < ActiveRecord::Base
  has_many :addresses
  belongs_to :region
  
  default_scope :order => 'name ASC'
end
