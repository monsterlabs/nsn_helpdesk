class Views::Admin::Links::Edit < Views::Layouts::Application
  def page_title
    "Edit Link"
  end
  
  def view_content
    rawtext error_messages_for 'link', :class => 'ui-state-error ui-corner-all'
    form_for(@link, :url => {:action => 'update', :id => @link.id}) do |f|
      h2 do
        text "Edit Link"
      end
      p do
        label "Sites"
        rawtext text_field_tag("link[sites]", @link.sites)
      end
      p do
        label "Frequency Tx"
        rawtext text_field_tag("link[frequency_tx]", @link.frequency_tx)
      end
      p do
        label "Frequency Rx"
        rawtext text_field_tag("link[frequency_rx]", @link.frequency_rx)
      end
      p do
        label "Time zone"
        rawtext collection_select :link, :time_zone_id, TimeZone.all, :id, :name
      end
      p do
        label "Status"
        rawtext text_field_tag("link[current_status]", @link.current_status)
      end
      
      rawtext f.submit 'Update', ui_style(:button)
      link_to  'Cancel', { :action => :index },  ui_style(:button)
    end
  end

end
