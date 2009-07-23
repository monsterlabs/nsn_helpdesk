class Views::Operator::Tickets::EditForm < Erector::RailsWidget
  needs :f

  def content
    table :id => "show" do
      
      div do 
        b 'Case ID '
        rawtext f.object.case_id
      end

      div :class => 'field' do
        label b "Region"
        rawtext filter_select :region, :customer_filter
      end

      div do 
        b 'Link'
        rawtext text_field_tag :link_sites, f.object.link.sites, :size => 40
      end

      div do 
        b 'Affected Site'
        rawtext text_field_tag :affected_site, f.object.affected_site, :size => 40
      end

      div do 
        b 'Frequency TX'
        rawtext f.text_field :frequency_tx, :size => 5
      end

      div do 
        b 'Frequency RX'
        rawtext f.text_field :frequency_rx, :size => 5
      end

      f.fields_for :priority do |priority|
        div do 
          b 'Priority'
          rawtext text_field_tag :name, f.object.priority.name, :size => 10
        end
      end

#         tr do 
#             td { b 'Subject' }
#             td { rawtext @ticket.failure.name }
#         end

#         tr do 
#             td { b 'Alarms' }
#             td { rawtext @ticket.alarm }
#         end

#         tr do 
#             td { b 'Customer' }
#             td { rawtext @ticket.reported_by.person.company.name }
#         end

#         tr do 
#             td { b 'Customer name' }
#             td { rawtext @ticket.reported_by.person.fullname }
#         end

#         tr do 
#             td { b 'Attended by' }
#             td { rawtext @ticket.attended_by.person.fullname}
#         end

#         tr do 
#             td { b 'Status' }
#             td { rawtext @ticket.status.name }
#         end

    end
    
  end

end
