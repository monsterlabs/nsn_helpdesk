class Views::Tickets::New < Views::Layouts::Application
  def setup
    @@jqueries << <<-S
    $('#timer').html("");
    $('#timer').epiclock({mode: EC_STOPWATCH, format: "x:i:s"}); 
    $('#timer').clocks(EC_RUN);
    S
  end

  def page_title
    "Add Ticket"
  end

  def view_content
    div :id => 'ticket_errors'
    rawtext error_messages_for 'ticket', :class => 'ui-state-error ui-corner-all'
    form_for(:ticket, @ticket, :url => { :action => "create"}, :html => {:id => 'new_ticket'}) do |f|
      h2 do
        text 'Case details'
      end

      widget Views::Tickets::Form, :f => f

      rawtext f.submit 'Create', ui_style(:button)
      link_to 'Cancel', {:action => :index},  ui_style(:button)
    end
  end

end
