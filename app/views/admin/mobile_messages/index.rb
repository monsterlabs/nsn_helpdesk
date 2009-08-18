class Views::Admin::MobileMessages::Index < Views::Layouts::Application
  def page_title
    "Mobile Messages"
  end

  def view_content
    table :id => "listing" do
      table_header ['CaseId or Link', 'Mobile Phone', 'Message', 'Status', 'Created at']
      table_body
    end
  end
  
  def table_body
    tbody do    
      @collection.each do |record|
        tr do
          if record.messageable_type == 'Ticket'
            td { rawtext record.messageable.case_id }
          else
            td { rawtext record.messageable.sites }
          end
          td { rawtext record.phone_number }
          td { rawtext record.body }
          td { rawtext (record.status ? 'Sent' : 'Pending') }
          td { rawtext record.created_at }
        end
      end
    end
    paginator @collection
  end

end
