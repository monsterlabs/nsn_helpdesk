class MobileMessage < ActiveRecord::Base
  validates_presence_of :phone_number
  default_scope :order => 'created_at DESC'
  belongs_to :ticket
  
  before_create :prepare_body
  after_create  :send_message
  
  def prepare_body
    self.body = self.ticket.summary
  end
  
  def send_message
    if `/opt/local/bin/php #{RAILS_ROOT}/tools/CalixtaClient.php #{phone_number} '#{body}'` == 't'
      update_attribute(:status, true)
    else
      update_attribute(:status, false)
    end
  end
end
