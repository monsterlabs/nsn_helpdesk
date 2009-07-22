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
  belongs_to :failure
  
  belongs_to :link  
  belongs_to :site

  default_scope :order => 'tickets.created_at DESC'

  named_scope :daily, :conditions => { :created_at => (Time.now.midnight..Time.now) }, :order => 'created_at'
  
  before_save :prepare_case_id

  def prepare_case_id
   self.case_id = 'NSNCT'+ (Date.today.strftime "%d%m%Y") + (Ticket.daily.size + 1).to_s
  end
end
