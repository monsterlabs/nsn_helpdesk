module DashboardHelper
  include AuthenticationSystem
  def mydashboard
    role = current_user.roles.first
    set_dashboard(role.name, Dashboard.parents_by_role_id(role.id))
  end

  def set_dashboard(name_space, collection)
    ul do
      collection.collect do |record|
        unless record.has_children?
            tab(record)
        else
            tab_with_children(record)
        #li record.controller.capitalize, :id => "t-proj"
        #   set_dashboard(name_space, record.children)
        end
     end
    end 
  end
  
  def tab(record)
    li :id => "t-proj" do 
      link_to(record.controller.capitalize, :controller => record.controller)
    end
  end
  
  def tab_with_children(record)
    li :id => "t-menu", :class => "submenu-tab" do 
      link_to(record.controller.capitalize + '<em>more</em>', :controller => record.controller)
    end
  end
  
end