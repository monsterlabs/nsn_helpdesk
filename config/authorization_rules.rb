authorization do
  role :operator do
    # Add permissions for operators here, e.g.
    has_permission_on :tickets, :to => :create_and_read
    has_permission_on [:user_settings, :user_settings, :people], :to => :read_and_update
    has_permission_on :feedbacks, :to => :write
  end

  role :field_manager do
    has_permission_on :tickets, :to => :read_and_update
    has_permission_on [:user_settings, :user_settings, :people], :to => :read_and_update
    has_permission_on :feedbacks, :to => :write
  end
  
  # Permissions for admin here
  role :admin do
    has_permission_on :user_settings, :to => :manage
    has_permission_on :user_setting, :to => :manage
    has_permission_on :users, :to => :manage
    has_permission_on :tickets, :to => :manage
    has_permission_on :feedbacks, :to => :write
    has_permission_on [:regions, :priorities, :statuses, :failures, :ticket_types, :alarm_types, :companies, :products], :to => :manage
  end
end

privileges do
  # default privilege hierarchies to facilitate RESTful Rails apps
  privilege :manage, :includes => [:create, :read, :update, :delete, :destroy]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
  
  privilege :create_and_read, :includes => [:create, :read]
  privilege :read_and_update, :includes => [:edit, :read, :update]
end
