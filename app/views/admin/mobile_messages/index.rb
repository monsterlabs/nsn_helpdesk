class Views::Admin::MobileMessages::Index < Views::Layouts::Application
  
  js  "jquery.floatheader"
  
  def page_title
    "Mobile Messages"
  end

  def view_content
    jquery "$('#listing').floatHeader(); $('div.floatHeader tr').removeClass('odd').addClass('ui-widget-header');"
    table :id => "listing" do
      table_header ['CaseId or Link', 'Mobile Phone', 'Message', 'Status', 'Created at']
      table_body
    end
    paginator @collection
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

  end

end
