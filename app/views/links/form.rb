class Views::Links::Form < Views::Layouts::Application
  needs :record
  
  def content
    rawtext hidden_field_tag(:id, record.id) 
    div :class => 'field' do
      label "Sites"
      rawtext text_field_tag("link[sites]", record.sites, :size => 30)
    end

    if current_user.role_symbols.include? :field_manager or current_user.role_symbols.include? :admin
      div :class => 'field' do
        label "Region"
        rawtext collection_select :link, :region_id, Region.all, :id, :name, :selected => record.region_id
      end
    end

    div :class => 'field' do
      label "City"
      rawtext collection_select :link, :city_id, City.all, :id, :name, :selected => record.city_id
      link_to_remote("Add", {:url => {:controller => 'admin/cities', :action => 'new'},
              :with => "'region_id=' + $('#customer_filter_region_id').val()",
              :update => {:success => "add_city_dialog"}, 
              :success => '$("#add_city_dialog").dialog({
                bgiframe: true,
                height: 200,
                width: 400,
                modal: true,
                autoOpen: false,
                draggable: false,
                resizable: false
              });
              $("#add_city_dialog").dialog("open");
              set_button_behaviour();'},
              ui_style(:button, {:class => "no_float"}))
    end
    
    div :id => 'add_city_dialog'

    div :class => 'field' do
      label "Frequency Tx"
      rawtext text_field_tag("link[frequency_tx]", record.frequency_tx, :size => 10)
    end

    div :class => 'field' do
      label "Frequency Rx"
      rawtext text_field_tag("link[frequency_rx]", record.frequency_rx, :size => 10)
    end

    div :class => 'field' do
      label "Time zone"
      rawtext collection_select :link, :time_zone_id, TimeZone.all, :id, :name, :selected => record.time_zone_id
    end

    div :class => 'field' do
      label "Configuration"
      rawtext text_field_tag("link[configuration]", record.configuration)
    end
    
  end
end
