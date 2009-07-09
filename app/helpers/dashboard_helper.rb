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
          li :id => "t-proj" do 
            link_to_function record.controller.capitalize, "$('##{record.controller + '_children'}').toggle();",  :id => record.controller + '_link'
            ul :class => "submenu", :style=>"display: none;", :id => (record.controller + '_children') do
              record.children.collect do |child|
                li do
                  link_to child.controller, :controller => child.controller
                end
              end
            end
          end
        end
      end
    end 
  end

  def tab(record)
    li :id => "t-proj" do 
      link_to(record.controller.capitalize, :controller => record.controller)
    end
  end

end