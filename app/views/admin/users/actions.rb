class Views::Admin::Users::Actions < Erector::RailsWidget
  needs :record_id
  
  def content
    rawtext link_to("Edit", {:action => 'edit', :id => record_id},
            ui_style(:button))
    rawtext link_to_remote("Delete", {:url => {:action => 'delete', :id => record_id}, :confirm => 'Are you sure to delete this user?'},
            ui_style(:button))
  end
  
end