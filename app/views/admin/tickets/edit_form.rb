class Views::Admin::Tickets::EditForm < Erector::RailsWidget
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
        rawtext hidden_field_tag 'ticket[link_id]'
      end

      div do 
        b 'Affected Site'
        rawtext f.text_field :affected_site
      end

    end
    
  end

end
