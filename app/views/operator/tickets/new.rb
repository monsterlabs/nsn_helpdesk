class Views::Operator::Tickets::New < Views::Layouts::Application
  def page_title
    "Add Ticket"
  end

  def view_content
    rawtext error_messages_for 'ticket', :class => 'ui-state-error ui-corner-all'
    form_for(:ticket, @ticket, :url => { :action => "create"}) do |f|
#       h2 do
#         text 'Add user'
#       end
#       widget Views::Admin::Users::Form, :f => f, :user => @user
      
      rawtext f.submit 'Create', ui_style(:button)
     end
  end

end
