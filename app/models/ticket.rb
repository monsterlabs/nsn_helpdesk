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
  belongs_to :attended_by, :class_name => 'User'
  
  default_scope :order => 'tickets.created_at DESC, tickets.subject ASC'

  def convert_to_date(date_params)
    year =  date_params['data(1i)'].to_i
    month = date_params['data(2i)'].to_i
    day = date_params['data(3i)'].to_i
    Date.new(year, month, day)
  end
end
