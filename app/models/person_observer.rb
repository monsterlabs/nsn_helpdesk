class PersonObserver < ActiveRecord::Observer
  observe :person

  def after_update(person)
    unless (person.user.role_symbols.include? :operator) or (person.user.role_symbols.include? :field_manager)
      Notifier.deliver_person_notifications(person)
    end
  end

end
