class MobileMessage < ActiveRecord::Base
  validates_presence_of :phone_number, :body
  default_scope :order => 'created_at DESC'
end
