class Views::Tickets::Table < Erector::RailsWidget
  needs :collection

  def content
    table :id => "listing", :class => "tickets-table" do
      table_header
      table_filter
      table_body
    end
    paginator @collection
  end

  def table_header
    thead :class => "ui-widget-header", :id => "listing-head" do
      tr do
        columns = %w(case_id region link affected_site status reported_priority recomended_priority customer local_datetime link_datetime actions)
        columns << 'change_status' if current_user.role_symbols.include? :field_manager
        columns.each  do |column|
          th :id => column do
            text ActiveSupport::Inflector.humanize(column)
          end
        end
      end
    end
  end
  
  def table_body
    tbody :id => "tickets" do
      widget Views::Tickets::Record, :collection => @collection
    end # end tbody
  end
  
  def table_filter
    form_remote_tag :url => "tickets/filter", :update => { :success => "tickets"}, :complete => "colorize_odd_rows()" do
      tr :id => "filter_row" do
        td :class => "filter_column" do
          rawtext text_field_tag "filter[case_id]"
        end
        td :class => "filter_column" do
          rawtext simple_select :filter, :region, :prompt => ""
        end
        td # Link
        td :class => "filter_column" do
          rawtext text_field_tag "filter[site]"
        end
        td :class => "filter_column" do
          rawtext simple_select :filter, :status, :prompt => ""
        end
        td :class => "filter_column" do
            rawtext simple_select :filter, :priority, {:prompt => "", :method_name => :reported_priority_id}
        end

        td :class => "filter_column" do
            rawtext simple_select :filter, :priority, :prompt => ""
        end

        td # Customer
        td # Opened datetime
        td # Link datetime
        td if current_user.role_symbols.include? :field_manager
        td { # Actions
          rawtext submit_tag "Filter", ui_style(:button)
        }
      end # end tr
    end # end form
  end
end

