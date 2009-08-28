class Views::Admin::Failures::CreateJs < Views::Layouts::ApplicationJs
  def js_content
    # I'm not using simple_select to make a custom selection on the newly created record
    rawtext select(:ticket, :failure_id, options_from_collection_for_select(Failure.all, 'id', 'failure_length_limited', @record.id))
  end
end