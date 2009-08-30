class Views::Shared::ShowLog  < Views::Layouts::Application
  needs :record
  def content
    table :id => "listing" do
      tr :id => "ticket_title" do
        td {}
        td {b "#{@record.class.name} version(s)"}
      end
      tr do
        td:id => 'ticket_left_cell' do
          rawtext b "This #{@record.class.name} has #{@record.versions.size - 1} version(s)"
        end
        td :id => 'ticket_right_cell' do
        end
      end

      record.versions.shift
      record.versions.reverse.each do |version|
        tr do
          td:id => 'ticket_left_cell' do
          end
          td :id => 'ticket_right_cell' do
            rawtext b "Version #{version.index}"
          end
        end
        tr do
          td:id => 'ticket_left_cell' do
            text "Version info"
          end
          td :id => 'ticket_right_cell' do
            rawtext  "#{version.event}d by: #{ who_has_changed_it(version.whodunnit.to_i)} at #{version.created_at}"
          end
        end
        
        (version.reify.attribute_names - ['created_at', 'updated_at', 'id', 'user_id', 'photo_updated_at', 'modified_by_id']).each do |attr|
          tr do
            td:id => 'ticket_left_cell' do
              text ActiveSupport::Inflector.humanize(attr) + ': '
            end

            td :id => 'ticket_right_cell' do
              if attr =~ /\_id$/
                model_name = attr.sub(/\_id$/,'')
                text version.reify.send(model_name).name unless version.reify.send(model_name).nil?
              else
                if attr == 'ip_address'
                  text version.reify.send(attr).to_s.slice(7..22)
                else
                  text version.reify.send(attr)
                end
              end
            end
          end
        end
      end
    end
  end
end

