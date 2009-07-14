class Views::Admin::Users::Record < Erector::RailsWidget
  needs :collection
  
  def content
    table do
      table_header
      table_body
    end
  end
  
  def table_header
    thead do
      th { text "Photo" }
      th { text "Fullname" }
      th { text "Login" }
      th { text "Email" }
      th { text "Actions" }
      
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
          td do 
              link_to 'Edit', {:action => :edit, :id => record.id}, ui_style(:button)
              link_to 'Show', {:action => :show, :id => record.id}, ui_style(:button)
              link_to 'Destroy', {:action => :destroy, :id => record.id}, 
                  {:method => :delete, :confirm => 'Do you want to delete this record ?'}.merge(ui_style(:button))
          end
        end
      end
    end
  end
  
end