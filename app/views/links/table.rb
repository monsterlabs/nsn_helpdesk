class Views::Links::Table < Erector::RailsWidget
  needs :collection
  def content
    table :id => "listing" do
      table_header %w(site  frequency_tx frequency_rx region configuration city  actions)
      table_filter
      table_body
    end
  end

  def table_body
    tbody :id => "links" do
      widget Views::Links::Record, :collection => @collection
    end
  end

  def table_filter
    form_remote_tag :url => "links/filter", :update => { :success => "links"}, :complete => "colorize_odd_rows()" do
         tr :id => "filter_row" do

            td :class => "filter_column" do
              rawtext text_field_tag "filter[sites_like]"
            end
            
            td :class => "filter_column" 
            td :class => "filter_column" 

            td :class => "filter_column" do
              rawtext simple_select :filter, :region, :prompt => ""
            end
            td :class => "filter_column" do
               rawtext select :filter, :configuration, [ ['1 + 1', '1 + 1'], ['1 + 0', '1 + 0'], ['0 + 0', '0 + 0'] ], :prompt => ""
            end
            td :class => "filter_column" do
              rawtext simple_select :filter, :time_zone, :prompt => ""
            end

            td { # Actions
              rawtext submit_tag "Filter", ui_style(:button)
            }
          end # end tr
    end # end form
  end
end
