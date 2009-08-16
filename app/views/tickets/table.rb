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
        columns = %w(case_id region link affected_site status reported_priority customer local_datetime actions)
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
  action_name = 'mine' if params[:filter] && params[:filter].has_key?(:attended_by_id_equals)
  action_name ||= 'index'
  jquery %Q($("tr#filter_row select").change(function() {
      $.ajax({
        complete:function(request){colorize_odd_rows()}, 
        data:$.param($("form").serializeArray()),
        success:function(request){$('#tickets').html(request);},
        type:'post', 
        url:'/tickets/#{action_name}'}); 
        return false; });)
  
  form_remote_tag :url => "/tickets/#{action_name}", :update => { :success => "tickets"}, :complete => "colorize_odd_rows()" do
      tr :id => "filter_row" do
        rawtext hidden_field_tag "filter[attended_by_id_equals]", current_user.id if params[:filter] && params[:filter].has_key?(:attended_by_id_equals)
        td :class => "filter_column" do
          rawtext text_field_tag "filter[case_id_like]"
        end
        td :class => "filter_column" do
          rawtext simple_select :filter, :region, :method_name => :region_id_equals,:prompt => "" unless current_user.roles.first.name == 'corporate'
        end
        td :class => "filter_column" do
          rawtext text_field_tag "filter[sites_like]"
        end
        td
        td :class => "filter_column" do
          rawtext simple_select :filter, :status, :method_name => :status_id_equals, :prompt => ""
        end
        td :class => "filter_column" do
            rawtext simple_select :filter, :priority, :method_name =>:reported_priority_id_equals, :prompt => ""
        end

        td # Customer
        td # Opened datetime
        td if current_user.role_symbols.include? :field_manager
        td { # Actions
          rawtext submit_tag "Filter", ui_style(:button)
        }
      end # end tr
    end # end form
  end
end

