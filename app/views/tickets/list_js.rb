class Views::Tickets::ListJs < Views::Layouts::ApplicationJs
  def js_content
    widget Views::Tickets::Record, :collection => @collection
  end
end
