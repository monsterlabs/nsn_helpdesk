class Views::Admin::Users::Record < Erector::RailsWidget
  needs :collection
  
  def content
    table :id => "listing" do
      table_header %w(Photo Fullname Login Email Actions)
      table_filter
      table_body
    end
  end

  def table_body
    tbody do
      collection.each do |record|
        tr do
          if record.person.nil? 
              td { rawtext image_tag "/photos/thumb/missing.png" }
          else
              td { rawtext image_tag record.person.photo.url(:thumb) }
          end
          td { text record.person.fullname unless record.person.nil? }
          td { text record.login }
          td { text record.email }
          td :class => "actions_column" do
            link_to 'Edit', {:action => :edit, :id => record.id}, ui_style(:button) 
            link_to 'Show', {:action => :show, :id => record.id}, ui_style(:button) 
            if current_user.role_symbols.include? :admin
              link_to 'Destroy', {:action => :destroy, :id => record.id}, 
                {:method => :delete, :confirm => 'Do you want to delete this record ?'}.merge(ui_style(:button))
            end
          end
        end
      end
    end
  end
  
  def table_filter
    tr :id => "filter_row" do
      td :class => "filter_column"
      td :class => "filter_column" do
        rawtext text_field_tag "filter", params[:filter]
      end
      td :class => "filter_column" 
      td :class => "filter_column"
      td {
        rawtext submit_tag "Filter", ui_style(:button)
      }
    end # end tr
  end
  
end