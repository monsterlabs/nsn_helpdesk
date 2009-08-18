class LinkObserver < ActiveRecord::Observer
  observe :link

  def after_update(link)
    #MobileMessage.create(:messageable => link, :phone_number => link.emergency_phone_number) if ENV['RAILS_ENV'] == 'production'
    Notifier.queue(:link_notifications, link) if !link.modified_by.has_role?(:admin) and !link.modified_by.has_role?(:field_manager)
  end

end
