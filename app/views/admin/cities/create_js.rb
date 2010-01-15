class Views::Admin::Cities::CreateJs < Views::Layouts::ApplicationJs
  def js_content
    # I'm not using simple_select to make a custom selection on the newly created record
    rawtext select(:link, :city_id, options_from_collection_for_select(City.all, 'id', 'name', @record.id))
  end
end