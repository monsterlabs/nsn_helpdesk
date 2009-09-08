class LinkObserver < ActiveRecord::Observer
  observe :link

  def after_update(link)
    link.region.users.field_managers.each do |fm|
      fm.mobile_phones.each do |phone_number|
        # MobileMessage.create(:messageable => link, :phone_number => phone_number)
      end
    end
    Notifier.queue(:link_notifications, link) 
  end
end
