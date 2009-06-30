class Views::Admin::Users::Actions < Erector::RailsWidget
  needs :record_id
  
  def content
    rawtext link_to("Edit", {:action => 'edit', :id => record_id}, as_button)
    rawtext link_to_remote("Delete", {:url => {:action => 'delete', :id => record_id}, :confirm => 'Are you sure to delete this user?'}, as_button)
  end
  
end