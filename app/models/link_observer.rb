class LinkObserver < ActiveRecord::Observer
  observe :link

  def after_update(link)
    if ENV['RAILS_ENV'] == 'production'
      User.field_managers.last.mobile_phones do |phone_number|
        # MobileMessage.create(:messageable => link, :phone_number => phone_number)
      end
    end
    Notifier.queue(:link_notifications, link) if !link.modified_by.has_role?(:admin) and !link.modified_by.has_role?(:field_manager)
  end

end
