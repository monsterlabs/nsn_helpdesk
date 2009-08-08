class Views::Admin::Links::New < Views::Layouts::Application
  def page_title
    "Add Link"
  end
  
  def view_content
    rawtext error_messages_for 'link', :class => 'ui-state-error ui-corner-all'
    form_for(:link, @link, :url => {:action => 'create'} ) do |f|
      h2 do
        text "Add Link"
      end
      p do
        label "Region"
        rawtext collection_select :link, :region_id, Region.all, :id, :name
      end
      p do
        label "City"
        rawtext collection_select :link, :city_id, City.all.sort {|x,y| x.name <=> y.name}, :id, :name
      end
      p do
        label "Sites"
        rawtext text_field_tag("link[sites]")
      end
      p do
        label "Frequency Tx"
        rawtext text_field_tag("link[frequency_tx]")
      end
      p do
        label "Frequency Rx"
        rawtext text_field_tag("link[frequency_rx]")
      end
      p do
        label "Time zone"
        rawtext collection_select :link, :time_zone_id, TimeZone.all, :id, :name
      end
      p do
        label "Status"
        rawtext text_field_tag("link[current_status]")
      end
      
      rawtext f.submit 'Create', ui_style(:button)
      link_to 'Cancel', {:action => :index},  ui_style(:button)
    end
  end

end