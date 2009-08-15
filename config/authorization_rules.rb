authorization do
  role :operator do
    # Add permissions for operators here, e.g.
    has_permission_on [:users, :links, :user_settings, :change_passwords], :to => :read_and_update
    has_permission_on :tickets, :to => :create_and_read
    has_permission_on [:feedbacks, :failures], :to => :write
  end

  role :field_manager do
    has_permission_on :tickets, :to => :manage
    has_permission_on [:links, :users], :to => :manage
    has_permission_on [:user_settings, :change_passwords], :to => :read_and_update
    has_permission_on [:feedbacks, :failures], :to => :write
  end

  # Permissions for admin here
  role :admin do
    has_permission_on :users, :to => :manage
    has_permission_on :tickets, :to => :manage
    has_permission_on :feedbacks, :to => :write
    has_permission_on :mobile_messages, :to => :read
    has_permission_on [:user_settings, :change_passwords], :to => :read_and_update
    has_permission_on [:companies, :failures, :links, :priorities, :products, :regions, :roles, :statuses, :ticket_types], :to => :manage
  end

  # Permissions for admin here
  role :corporate do
    has_permission_on :tickets, :to => [:read, :filter]
    has_permission_on [:user_settings, :change_passwords], :to => :read_and_update
    has_permission_on :feedbacks, :to => :write
  end

end

privileges do
  # default privilege hierarchies to facilitate RESTful Rails apps
  shared_actions = [:details, :auto_complete_for_person_lastname_firstname, :auto_complete_for_link_sites, :filter]
  privilege :manage, :includes => ([:create, :read, :update, :delete, :destroy, :change_status, :edit_change_status ] + shared_actions)
  privilege :change_status, :includes => [:change_status, :edit_change_status]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
  privilege :write, :includes => :create
  privilege :create_and_read, :includes => ([:create, :read] + shared_actions)
  privilege :read_and_update, :includes => ([:edit, :read, :update, :show] + shared_actions)
end
