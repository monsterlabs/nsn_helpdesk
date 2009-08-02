class AddressObserver < ActiveRecord::Observer
  observe :address

  def after_update(address)
    unless (address.user.role_symbols.include? :operator) or (address.user.role_symbols.include? :field_manager)
      Notifier.deliver_address_notifications(address)
    end
  end

end
