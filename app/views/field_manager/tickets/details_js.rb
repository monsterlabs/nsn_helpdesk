class Views::FieldManager::Tickets::DetailsJs < Views::Layouts::ApplicationJs
  def js_content
    widget Views::Operator::Tickets::Details
  end
end
