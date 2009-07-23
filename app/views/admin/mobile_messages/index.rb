class Views::Admin::MobileMessages::Index < Views::Layouts::Application
  def page_title
    "Mobile Messages"
  end

  def view_content
    table :id => "listing" do
      table_header %w(CaseId MobilePhone Message Status CreatedAt)
      table_body
    end
  end
  
  def table_body
    tbody do    
       @collection.each do |record|
        td { rawtext record.ticket.case_id  }
        td { rawtext record.phone_number }
        td { rawtext record.body }
        td { rawtext (record.status ? 'Sent' : 'Pending') }
        td { rawtext record.created_at }
      end
    end
    paginator @collection
  end

end
