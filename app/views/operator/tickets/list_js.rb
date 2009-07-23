class Views::Operator::Tickets::ListJs < Views::Layouts::ApplicationJs
  def js_content
    widget Views::Operator::Tickets::Record, :collection => @collection
    paginator(@collection) if @collection.total_pages > 1
  end
end
