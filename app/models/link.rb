class Link < ActiveRecord::Base
  has_paper_trail

  has_many :tickets
  belongs_to :region
  belongs_to :city
  belongs_to :time_zone
  belongs_to :user
  belongs_to :link

  belongs_to :modified_by, :class_name => 'User'

  has_many :mobile_messages, :as => :messageable
  has_many :mails, :as => :mailable
  
  def self.search_and_paginate(search = :all,page = 1, per_page = 10)
      Link.search(search).all.paginate(:page => page, :per_page => per_page)
  end

  named_scope :city_like, lambda { |city_name|
    { :conditions => ['LOWER(cities.name) LIKE ? ', "%#{city_name.downcase}%" ], 
      :joins => 'left join cities on cities.id = links.city_id' }
  }

  
  def summary
    modified_by ||= User.find_by_login('admin')
    modified_by_user = modified_by.person.nil? ? modified_by.email : modified_by.person.fullname
    unless modified_by.address.nil?
      phone_number = modified_by.address.business_phone || modified_by.address.mobile_phone
    else
      phone_number = 'Not available'
    end
    
    'A link has been updated: ' + \
      [ 'Link: ' + sites, 
        'Region: ' + region.name,
        'Current Status: ' + current_status.to_s,
        'Time zone: ' + time_zone.name,
        'Modified by: ' + modified_by_user,
        'Phone: ' + phone_number,
        'Changed at: ' + updated_at.to_s(:short) 
      ].join(', ')
    end
end
