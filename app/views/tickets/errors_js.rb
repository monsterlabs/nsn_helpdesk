class Views::Tickets::ErrorsJs < Views::Layouts::ApplicationJs
  def js_content
    errors = error_messages_for('ticket', :class => 'ui-state-error ui-corner-all').gsub(/\'/,'`')
    rawtext "$.blockUI({message: '#{errors}', css: {cursor: 'pointer', 'z-index': 1005}, baseZ: 1004});
          $(\"#errorExplanation\").click(function() {
            $.unblockUI(); 
            return false;
          });"
  end
end