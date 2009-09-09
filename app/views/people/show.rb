class Views::People::Show < Views::Layouts::Application
  needs :person
  def content
    unless @person.nil?
      div :class => 'grid_10' do
        div :class => 'grid_4  alpha', :style => 'margin-left: -10px;' do
          h2 'Datos personales'
          table :id => "profile-info" do
            tr do 
              td { b 'Firstname:' }
              td { rawtext @person.firstname }
            end

            tr do 
              td { b 'Lastname:' }
              td { rawtext @person.lastname }
            end

            tr do 
              td { b 'Company:' }
              td { rawtext @person.company.name  unless @person.company.nil? }
            end

            tr do
              if @person.user.has_role? :field_manager 
                td { b 'Regions:' }
                td {
                  ul do
                    @person.user.regions.each do |region|
                      li {rawtext region.name}
                    end
                  end
                  br
                }
              else
                td { b 'Region:' }
                td { rawtext @person.region.name unless @person.region.nil? }
              end
            end
          end
        end
        div :class => 'grid_4 prefix_2 omega', :id => 'photo', :style => 'padding-top: 30px; margin-left: -20px;' do
          if @person.photo.size == nil
            rawtext image_tag "/photos/thumb/missing.png"
          else
            rawtext image_tag @person.photo.url(:medium)
          end                    
        end
      end
    end
  end
end
