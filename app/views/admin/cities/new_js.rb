class Views::Admin::Cities::NewJs < Views::Layouts::ApplicationJs
  def js_content
    div :id => "add_city_dialog", :title => "Add a failure" do
      form_remote_tag(:url => "/admin/cities/create", :success => "$('#link_city_id').replaceWith(request); $('#add_city_dialog').dialog('close');") do
        div :class => 'field' do
          label "Name"
          rawtext text_field_tag 'city[name]'
        end

        div :class => 'field' do
          label "Region"
          rawtext simple_select 'city[region_id]', :region
        end
        div :class => 'field' do
          label "State"
          rawtext simple_select 'city[state_id]', :state
        end
        rawtext submit_tag 'Create', ui_style(:button)
      end
    end
  end
end