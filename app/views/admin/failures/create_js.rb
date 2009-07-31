class Views::Admin::Failures::CreateJs < Views::Layouts::ApplicationJs
  def js_content
    rawtext simple_select :ticket, :failure
  end
end