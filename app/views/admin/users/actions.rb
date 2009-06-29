class Views::Admin::Users::Actions < Erector::RailsWidget
  needs :record_id
  
  def content
    rawtext link_to("Edit", :action => 'edit', :id => record_id)
    # delete is not working since we need a new dom_id method
    #rawtext link_to_remote("Delete", :url => {:action => 'delete', :id => record_id}, :confirm => 'Are you sure to delete thhis user?')
  end
  
end