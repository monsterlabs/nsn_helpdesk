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

  has_many   :ticket_comments
  accepts_nested_attributes_for :ticket_comments

  default_scope :order => 'tickets.created_at DESC'

  named_scope :daily, lambda { {:conditions => { :created_at => (Time.zone.now.midnight..Time.zone.now) }, :order => 'created_at ASC'} }
  
  before_save :prepare_case_id

  def prepare_case_id
    date = Date.today.strftime "%d%m%Y"
    last = Ticket.daily.last
    serial = last.case_id.match(/.{13}(.*)/)[1].next if last
    serial ||= 1 
    self.case_id = "NSNCT#{date}#{serial}"
  end
  
  def affected_sites
    affected_site.to_s.empty? ? 'Both' : affected_site
  end
  
  def summary
    [ case_id, 'Priority: ' + priority.name, 'Region: ' + link.region.name, 'Link: ' + link.sites, 
    'Affected sites: ' + affected_sites, 'Created at: ' + created_at.to_s(:short) ].join(', ')
  end
  
  def emergency_phone_number
    '5522159641'
  end

  def capture_time
    time = self.created_at - self.opened_at
    time = format("%.2f", time)
    time = time.to_s + " seconds"
  end
  
  def due_date
    self.priority.name == "0+0 High" ? self.created_at + 2.hours : due_date = self.created_at + 10.days 
  end

end
