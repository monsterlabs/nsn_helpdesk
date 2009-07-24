class Ticket < ActiveRecord::Base
  has_paper_trail 

  validates_presence_of :product_id, :reported_by_id, :link_id, :frequency_tx, :frequency_rx, :reported_priority_id, :failure, :attended_by_id
  
  belongs_to :ticket_type
  belongs_to :reported_priority, :class_name => 'Priority'
  
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
    reported_by_user = reported_by.person.nil? ? reported_by.email : reported_by.person.fullname
    unless reported_by.address.nil?
      phone_number = reported_by.address.business_phone || reported_by.address.mobile_phone
    else
      phone_number = 'Not available'
    end
    call_attended_by_user = attended_by.person.nil? ? attended_by.email : attended_by.person.fullname
    [ 'Link: ' + link.sites, 
      'Affected sites: ' + affected_sites,
      'Region: ' + link.region.name,
      'Status: ' + status.name,
      'Priority: ' + reported_priority.name,
      'Reported by: ' + reported_by_user,
      'Phone: ' + phone_number,
      'Case ID: ' + case_id, 
      'NSN Engineer: '  + call_attended_by_user,
      'Sent at: ' + created_at.to_s(:short) 
      ].join(', ')
  end
  
  def emergency_phone_number
    '5522159641'
  end

  # Fix It: Change method name to capture_duration
  def capture_time
    if !created_at.nil? and !opened_at.nil?
      # Fix It: Calculate duration
      min, sec = ((created_at - opened_at ) / 60).to_s.split('.')
      "#{min} min. #{sec[0,1]} sec."
    end
  end
  
  def due_date
    self.priority.name == "0+0 High" ? self.created_at + 2.hours : due_date = self.created_at + 10.days 
  end

end
