class Views::Users::ErrorJs < Views::Layouts::ApplicationJs
  def js_content
    rawtext error_messages_for 'user', :class => 'ui-state-error ui-corner-all'
  end
end