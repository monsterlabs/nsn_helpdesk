class Views::People::Show < Views::Layouts::Application
  needs :person
  def content
    unless @person.nil?
      h2 'Datos personales'
      # div :class => 'alpha prefix_3 grid_1' do
      #   if @person.photo.size == nil
      #     rawtext image_tag "/photos/thumb/missing.png"
      #   else
      #     rawtext image_tag @person.photo.url(:thumb)
      #   end
      # end
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
          td { b 'Region:' }
          td { rawtext @person.region.name unless @person.region.nil? }
        end
      end
    end
  end
end
