class Views::Links::ShowRecordJs < Views::Layouts::ApplicationJs
  needs :record
  include AuthenticationSystem
  def js_content
    widget Views::Links::ShowRecord, :record => record
    link_to_remote("Edit",  { :url => {:controller => 'links', :action => 'edit', :id => record.id}, :method => :get,
               :with => "'region_id=' + $('#customer_filter_region_id').val()",
               :update => {:success => "add_edit_dialog"}, 
               :success => '$("#add_edit_dialog").dialog({
                 bgiframe: true,
                 height: 280,
                 modal: true,
                 autoOpen: false,
                 draggable: false,
                 resizable: false
               }); 
               $("#add_edit_dialog").dialog("open");
               set_button_behaviour();'},
               ui_style(:button)) 
               
  end
end