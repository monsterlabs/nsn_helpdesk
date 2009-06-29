class Views::Admin::Users::Record < Erector::RailsWidget
  needs :collection
  
  def content
    collection.each do |record|
      div :id => dom_id(record) do
        rawtext dom_id(record)
        span do
          rawtext image_tag record.person.photo.url(:thumb)
        end
        span { b { text "id" } }
        span { text record.id  }
        span { b { text "nombre" } }
        span { text record.person.firstname + ' ' + record.person.lastname1  }
        span { b { text "login" } }
        span { text record.login  }
        span { b { text "email" } }
        span { text record.email  }
        widget Views::Admin::Users::Actions, :record_id => record.id
      end
    end
  end
  
end