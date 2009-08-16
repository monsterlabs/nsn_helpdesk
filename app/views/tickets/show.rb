class Views::Tickets::Show < Views::Layouts::Application
  def page_title
    "Show Ticket"
  end
  
  def view_content
    table :id => "listing" do
      widget Views::Tickets::CurrentData, :ticket => @ticket
      unless @ticket.assigned_to.nil?
        widget Views::Tickets::FieldManagerData, :ticket => @ticket
      end
    end
    if @ticket.comments.size > 0
      table :id => "listing" do
        widget Views::Tickets::Comments, :ticket => @ticket
      end
    end
    if @ticket.versions.size > 0
      table :id => "listing" do
        widget Views::Tickets::Versions, :ticket => @ticket
      end
    end
     tr do
      td {rawtext link_to 'Back', {:action => 'index'}, ui_style(:button)}
    end
  end
end
