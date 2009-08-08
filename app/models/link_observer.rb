class LinkObserver < ActiveRecord::Observer
  observe :link

  def after_update(link)
    MobileMessage.create(:messageable => link, :phone_number => link.emergency_phone_number)
    Notifier.deliver_link_notifications(link) #if link.modified_by.login != 'admin'
  end

end
