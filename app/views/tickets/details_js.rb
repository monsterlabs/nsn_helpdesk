class Views::Tickets::DetailsJs < Views::Layouts::ApplicationJs
  def js_content
    widget Views::Tickets::Details, :region => @region
  end
end
