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
      th { text "id" }
      th { text "photo" }
      th { text "name" }
      th { text "login" }
      th { text "email" }
    end
  end

  def table_body
    tbody do
      collection.each do |record|
        tr do
          td { text record.id }
          td { rawtext image_tag record.person.photo.url(:thumb) }
          td { text record.person.firstname + ' ' + record.person.lastname1 }
          td { text record.login }
          td { text record.email }
        end
      end
    end
  end
  
end