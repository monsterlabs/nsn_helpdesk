class Ticket < ActiveRecord::Base
  
  has_paper_trail 
    
  belongs_to :ticket_type
  belongs_to :priority
  belongs_to :status
  belongs_to :product
  belongs_to :reported_by, :class_name => 'User'
  belongs_to :opened_by, :class_name => 'User'
  belongs_to :assigned_to, :class_name => 'User'
  belongs_to :attended_by, :class_name => 'User'
  
  belongs_to :link  
  belongs_to :site

  default_scope :order => 'tickets.created_at DESC'

end
