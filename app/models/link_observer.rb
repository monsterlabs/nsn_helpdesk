class LinkObserver < ActiveRecord::Observer
  observe :link

  def after_update(link)
    Notifier.deliver_link_notifications(link)
  end

end
