class Ticket < ActiveRecord::Base
  validates_presence_of :subject, :ticket_type_id, :region_id, :priority_id
  
  belongs_to :ticket_type
  belongs_to :priority
  belongs_to :region
  belongs_to :status
  belongs_to :product
  belongs_to :reported_by, :class_name => 'User'
  belongs_to :opened_by, :class_name => 'User'
  belongs_to :assigned_to, :class_name => 'User'
end
