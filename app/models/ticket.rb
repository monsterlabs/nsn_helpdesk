class Ticket < ActiveRecord::Base
  include ApplicationHelper

  has_paper_trail 

  validates_uniqueness_of :case_id
  validates_presence_of :product_id, :reported_by_id, :link_id, :reported_priority_id, :failure, :attended_by_id
  
  belongs_to :ticket_type
  belongs_to :reported_priority, :class_name => 'Priority'
  
  belongs_to :priority
  belongs_to :status
  belongs_to :product
  belongs_to :reported_by, :class_name => 'User'
  belongs_to :opened_by, :class_name => 'User'
  belongs_to :assigned_to, :class_name => 'User'
  belongs_to :attended_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'
  belongs_to :alternate_contact, :class_name => 'User'
  belongs_to :accepts_closing, :class_name => 'User'
  belongs_to :failure
  
  belongs_to :link  
  belongs_to :site

  has_many   :comments
  accepts_nested_attributes_for :comments
  
  has_many :mobile_messages, :as => :messageable, :dependent => :destroy
  has_many :mails, :as => :mailable

  default_scope :order => 'tickets.opened_at DESC'

  named_scope :daily, lambda { {:conditions => { :created_at => (Time.zone.now.midnight..Time.zone.now) }, :order => 'created_at ASC'} }
  
  named_scope :region_id_equals, lambda { |id|
    { :conditions => { 'links.region_id' => id }, 
      :joins => 'left join links on links.id = tickets.link_id' }
  }

  named_scope :region_id_equals_any, lambda { |ids|
    { :conditions => ids.collect { |id| "links.region_id = #{id}" }.join(' OR '),
      :joins => 'left join links on links.id = tickets.link_id' }
  }

  named_scope :sites_like, lambda { |sites|
    { :conditions => ["translate(LOWER(links.sites), '\303\241\303\251\303\255\303\263\303\272\303\274\303\261', 'aeiouun') LIKE ? ", "%#{sites.downcase}%" ], 
      :joins => 'left join links on links.id = tickets.link_id' }
  }
  named_scope :created_at_in_year_and_month, lambda { |year, month|
      m = month.to_s.length < 2 ? "0" + month.to_s : month.to_s 
      { :conditions => ["date_part('year', created_at)  = ? AND date_part('month', created_at) = ?", year.to_s, m.to_s] }
    }
  

  before_create :prepare_case_id
  before_update :disable_timestamp
  def prepare_case_id
    date = Date.today.strftime "%d%m%Y"
    last = Ticket.daily.last
    serial = last.case_id.match(/.{13}(.*)/)[1].next if last
    serial ||= 1 
    self.case_id = "NSNCT#{date}#{serial}"
  end
  
  def disable_timestamp
    if changes.include?(:updated_at) or changes.include?(:created_at)
      ActiveRecord::Base.record_timestamps = false
    end
    true
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
      'Priority: ' + priority_label(reported_priority.name),
      'Recommended priority: ' + priority_label(priority.name),
      'Reported by: ' + reported_by_user,
      'Phone: ' + phone_number,
      'Case ID: ' + case_id, 
      'NSN Engineer: '  + call_attended_by_user,
      'Sent at: ' + created_at.to_s(:short) 
      ].join(', ')
  end

  # Fix It: Change method name to capture_duration
  def capture_time
    if !created_at.nil? and !opened_at.nil?
      # Fix It: Calculate duration
      min, sec = ((created_at - opened_at ) / 60).to_s.split('.')
      "#{min} min. #{sec[0,1]} sec."
    end
  end
  
  def opened_at_local
    time_zone = link.time_zone.nil? ?  'America/Mexico_City' : link.time_zone.name
    tz = TZInfo::Timezone.get(time_zone)
    tz.utc_to_local(opened_at.utc).to_s + ' ' + link.time_zone.name
  end

  def self.search_and_paginate(search = :all,page = 1, per_page = 10)
      Ticket.search(search).all.paginate(:page => page, :per_page => per_page)
  end

end
