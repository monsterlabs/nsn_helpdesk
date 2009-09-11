class Views::SuperScaffold::Index < Views::Layouts::Application

  js  "jquery.floatheader"

  def page_title
    ""
  end
  
  def view_content
    jquery "$('#listing').floatHeader(); $('div.floatHeader tr').removeClass('odd').addClass('ui-widget-header');"
    # h1 { text "Model Name" }
    widget Views::SuperScaffold::Record, :collection => @collection, :columns => @columns
    paginator @collection
    rawtext link_to "Add", {:action => 'new'}, ui_style(:button)
  end
end
