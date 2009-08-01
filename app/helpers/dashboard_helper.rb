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
          tab(name_space, record)
        else
          li :id => record.controller + '_tab' do 
            #link_to_function record.controller.humanize, "$('##{record.controller + '_children'} li a').toggle(); $('##{record.controller + '_children'}').toggle()",  :id => record.controller + '_link'
            a :id => record.controller + '_link' do
              text record.controller.humanize
            end
            ul :class => "submenu", :style=>"display: none;", :id => (record.controller + '_children') do
              record.children.collect do |child|
                li do
                  link_to child.controller.humanize, :controller =>  name_space + '/' + child.controller
                end
              end
            end
          end
        end
      end
    end 
  end

  def tab(name_space, record)
    li :class => "t-proj" do 
      link_to(record.controller.humanize, :controller => name_space + '/' + record.controller)
    end
  end

end