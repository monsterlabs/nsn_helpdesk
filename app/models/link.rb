class Link < ActiveRecord::Base
  has_paper_trail

  has_many :tickets
  belongs_to :region
  belongs_to :city
  belongs_to :time_zone
  belongs_to :user
  belongs_to :link
  
  belongs_to :modified_by, :class_name => 'User'
end
