module DashboardHelper
  include AuthenticationSystem
  def mydashboard
    role = Role.find_by_name(current_user.role_symbols.first.to_s)
    set_dashboard(role.name, Dashboard.parents_by_role_id(role.id))
  end

  def set_dashboard(name_space, collection)
    ul do
      collection.collect do |record|
        unless record.has_children?
          tab(name_space, record)
        else
          li :id => record.controller + '_tab' do
            a :id => record.controller + '_link' do
              text (record.label || record.controller.humanize)
            end
            ul :class => "submenu", :style=>"display: none;", :id => (record.controller + '_children') do
              record.children.collect do |child|
                li do
                  mylabel = child.label || child.controller.humanize
                  link_to mylabel, :controller =>  (name_space + '/' + child.controller), :action => child.action
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
      link_to((record.label || record.controller.humanize), :controller => name_space + '/' + record.controller)
    end
  end

end
