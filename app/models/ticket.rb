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

  named_scope :daily, lambda { {:conditions => { :created_at => (Time.zone.now.midnight..Time.zone.now) }, :order => 'created_at ASC'} }
  
  before_save :prepare_case_id

  def prepare_case_id
   self.case_id = 'NSNCT'+ (Date.today.strftime "%d%m%Y") + Ticket.daily.last.case_id.match(/.{13}(.*)/)[1].next
  end
end
