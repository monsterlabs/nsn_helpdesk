ActionController::Routing::Routes.draw do |map|
  map.resource :session
  map.recover_password '/recover_password', :controller => "sessions", :action => "recover_password"
  map.login '/login', :controller => "sessions", :action => "new"
  map.logout '/logout', :controller => "sessions", :action => "destroy"

  map.resource :user_setting
  map.resources :people, :member => { :change_photo => :get , :update_photo => :get }
  map.resources :feedbacks
  
  map.namespace :admin do |admin|
    admin.resources :users
    admin.resources :priorities
    admin.resources :regions
    admin.resources :failures
    admin.resources :ticket_types
    admin.resources :alarm_types
    admin.resources :companies
    admin.resources :products
    admin.resources :tickets, :collection => { :list_by_priority => :get, :list_by_status=> :get, :list_by_region => :get }
  end  

  map.namespace :operator do |operator|
    operator.resources :tickets
  end  

  map.namespace :field_manager do |field_manager|
    field_manager.resources :tickets
  end  

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  map.root :controller => "sessions", :action => 'new'
  
  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
