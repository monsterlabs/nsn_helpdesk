class Views::Addresses::ShowLog < Erector::RailsWidget
  needs :addr

  def content
    fieldset do
      div :class => 'field' do 
        label h3 "This person record has #{@addr.versions.size} version(s)."
      end

   @addr.versions.reverse.each do |version|
      div :class => 'field' do 
         label "Version #{version.index + 1}:"
      end
      div :class => 'field' do 
         label "Created by:"
         rawtext Person.find_by_user_id(version.whodunnit).fullname unless Person.find_by_user_id(version.whodunnit).nil?
      end

       unless version.object.nil?
         div :class => 'field' do 
            label "IP Address:"
            rawtext version.object.split(/\n/).map {|part| part.split[1] if part.match(/ip_address/)}
         end
         div :class => 'field' do 
            label "Event"
            rawtext version.event
         end
       end
        div :class => 'field' do 
          label "Created at"
          rawtext version.created_at :short
        end
      end
    end
  end
end
