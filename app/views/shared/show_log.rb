class Views::Shared::ShowLog  < Views::Layouts::Application
  needs :record
  def content
    tr :id => "ticket_title" do
      td {}
      td {b 'Link Version(s)'}
    end
    tr do
      td:id => 'ticket_left_cell' do
        rawtext b "This link has #{@record.versions.size - 1} version(s)"
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
          rawtext  "#{version.event}d by: #{ who_has_changed_it(version.whodunnit.to_i)} at #{version.created_at(:short)}"
        end
      end
    end

    tr do
      td:id => 'ticket_left_cell' do
        text "Link"
      end
      td :id => 'ticket_right_cell' do
        rawtext record.sites
      end
    end

#             td { b "Version info:" }
#             td { text "#{version.event}d by: #{ who_has_changed_it(version.whodunnit.to_i)} at #{version.created_at(:short)}"}
#           end

#           tr do
#             td { b "Previous data:" }
#             td do
#               (version.reify.attribute_names - ['created_at', 'updated_at', 'id', 'user_id', 'photo_updated_at', 'modified_by_id']).each do |attr|
#                 b ActiveSupport::Inflector.humanize(attr) + ': ' 
#                 if attr =~ /\_id$/
#                   model_name = attr.sub(/\_id$/,'')
#                   text version.reify.send(model_name).name unless version.reify.send(model_name).nil?
#                 else
#                   text version.reify.send(attr)
#                 end
#                 br
#               end
#             end
#           end
#         end
#       end
   end

  def who_has_changed_it(user_id)
    @user= User.find(user_id)
    unless @user.nil?
      fullname =  @user.person.nil? ? 'admin' : @user.person.fullname
      "#{fullname} <#{@user.email}>"
    end
  end
end
