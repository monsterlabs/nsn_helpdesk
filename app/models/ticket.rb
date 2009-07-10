class Ticket < ActiveRecord::Base
  validates_presence_of :subject, :ticket_type_id, :region_id, :priority_id
  
  belongs_to :ticket_type
  belongs_to :priority
  belongs_to :region

end
