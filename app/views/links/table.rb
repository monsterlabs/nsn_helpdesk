class Views::Links::Table < Erector::RailsWidget
  needs :collection
  def content
    form_remote_tag :url => "links/filter", :update => { :success => "links_collection"}, :complete => "colorize_odd_rows()" do
      table :id => "listing" do
        table_header %w(site  frequency_tx frequency_rx region configuration city  actions)
        table_filter
        table_body
      end
    end
  end

  def table_body
    tbody :id => "links" do
      widget Views::Links::Record, :collection => @collection
    end
  end

  def table_filter
    tr :id => "filter_row" do
      td :class => "filter_column" do
        rawtext text_field_tag "filter[sites_like]", (params[:filter][:sites_like] if params[:filter])
      end

      td :class => "filter_column" 
      td :class => "filter_column" 

      td :class => "filter_column" do
        rawtext simple_select :filter, :region, {:prompt => "", :selected => (params[:filter] ? params[:filter][:region_id].to_i : nil)}
      end
      td :class => "filter_column" 
      td :class => "filter_column" do
        rawtext text_field_tag "filter[city_like]", (params[:filter][:city_like] if params[:filter])
      end

      td { # Actions
        rawtext submit_tag "Filter", ui_style(:button)
      }
    end # end tr
  end
end
