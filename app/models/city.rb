class City < ActiveRecord::Base
  belongs_to :region
  default_scope :order => 'name ASC'
end
