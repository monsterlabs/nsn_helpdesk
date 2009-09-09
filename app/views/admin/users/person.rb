class Views::Admin::Users::Person < Erector::RailsWidget
  needs :f, :user
  
  def content
    f.fields_for 'person_attributes', user.person do |person|
      rawtext person.hidden_field :id unless person.id.nil?
      if user.has_role? :field_manager
        div :class => 'field' do
          label "Regions"
          br
          div :id => 'regions' do
            f.fields_for :user_regions do |region_form|
              div :class => 'region' do
                label ""
                rawtext region_form.collection_select 'region_id', Region.all, :id, :name
                unless region_form.object.new_record?
                  rawtext region_form.hidden_field(:_delete)
                  rawtext link_to_function("Delete", "$(this).parent('.region').hide(); $(this).prev().val(1)", ui_style(:button, {:class => 'no_float'}))
                end
                br
              end # div.region
            end # fields_for
          end
          
          br
          label ""
          link_to_function("Add", "$('#regions').append('#{escape_javascript capture {
             f.fields_for 'user_regions', user.user_regions.build do |user_region_fields|
               label ""
               rawtext user_region_fields.collection_select 'region_id', Region.all, :id, :name
               br
             end
           }}');", ui_style(:button, {:class => 'no_float'}))
        end
      else
        div :class => 'field' do
          label "Region"
          rawtext person.collection_select :region_id, Region.all, :id, :name
        end
      end
      
      div :class => 'field' do
        label "Firstname"
        rawtext person.text_field :firstname 
      end
       div :class => 'field' do
        label "Lastname"
        rawtext person.text_field :lastname
      end
      if user.person.nil?
         div :class => 'field' do
          label "Photo"
          rawtext person.file_field :photo
        end
      else
         div :class => 'field' do
          label "Photo"
          rawtext person.file_field :photo
          end
      end
      unless current_user.roles.first.name == 'operator'
        div :class => 'field' do
          label "Company"
          rawtext person.collection_select :company_id, Company.all, :id, :name
        end
      end
    end
  end
  
end
