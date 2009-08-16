class Views::Tickets::ListJs < Views::Layouts::ApplicationJs
  def js_content
    widget Views::Tickets::Table, :collection => @collection
  end
end
