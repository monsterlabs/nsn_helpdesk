authorization do
  role :operator do
    # Asdd permissions for operators here, e.g.
    has_permission_on :tickets, :to => :create_and_read
    has_permission_on [:user_settings, :people] :to => :read_and_update
  end
  
  # Permissions for admin here
  role :admin do
    has_permission_on :user_settings, :to => :manage
    has_permission_on :users, :to => :manage
    has_permission_on [:regions, :priorities, :statuses], :to => :manage
  end
end

privileges do
  # default privilege hierarchies to facilitate RESTful Rails apps
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
  
  privilege :create_and_read, :includes => [:create, :read]
  privilege :read_and_update, :includes => [:edit, :read, :update]
end
