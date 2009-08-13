class Views::Shared::ShowLog  < Views::Layouts::Application
  needs :record
  def content
    if @record.respond_to? :versions and @record.versions.size > 1
      h2 'Changelog'
      h3 "This #{@record.class.name.downcase} has #{@record.versions.size - 1} version(s)"
      record.versions.shift
      record.versions.reverse.each do |version|
        table :id => "versions" do
          tr do
            td { b "Version number:" }
            td { text version.index }
          end

          tr do
            td { b "Version info:" }
            td { text "#{version.event}d by: #{ who_has_changed_it(version.whodunnit.to_i)} at #{version.created_at(:short)}"}
          end

          tr do
            td { b "Previous data:" }
            td do
              (version.reify.attribute_names - ['created_at', 'updated_at', 'id', 'user_id', 'photo_updated_at', 'modified_by_id']).each do |attr|
                b ActiveSupport::Inflector.humanize(attr) + ': ' 
                if attr =~ /\_id$/
                  model_name = attr.sub(/\_id$/,'')
                  text version.reify.send(model_name).name unless version.reify.send(model_name).nil?
                else
                  text version.reify.send(attr)
                end
                br
              end
            end
          end
        end
      end
    end
  end

  def who_has_changed_it(user_id)
    @user= User.find(user_id)
    unless @user.nil?
      fullname =  @user.person.nil? ? 'admin' : @user.person.fullname
      "#{fullname} <#{@user.email}>"
    end
  end
end