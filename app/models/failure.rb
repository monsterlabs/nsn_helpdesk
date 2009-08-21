class Failure < ActiveRecord::Base  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  default_scope :order => 'name ASC'

  has_many :tickets
  
  def failure_length_limited
    (name.length > 70) ? (name.slice(0..69) + '...') : name
  end
  
end
