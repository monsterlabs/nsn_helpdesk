class Views::Links::ShowJs < Views::Layouts::ApplicationJs
  def js_content
    widget Views::Links::ShowRecordJs, :record => @record
  end
end