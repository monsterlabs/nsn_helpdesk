# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def priority_label(name)
    case name
    when 'Low' then
      sufix = '1 + 1'
    when 'Medium' then 
      sufix = '1 + 0'
    when 'High' then
      sufix ='0 + 0'
    end
    name + ' ' + sufix
  end
  
  def show_value(record, attribute)
    record.send(attribute).to_s.strip.empty? ? "none" : record.send(attribute)
  end
  
  def status_indicator(ticket)
     status = ticket.status.name
     img :src => "/images/#{status.downcase}.png", :width => '12px', :height => '12px'
     span :class => status.downcase do
        rawtext status
        if status == 'Open' and ticket.versions.size > 1
            opened_versions = ticket.versions.collect { |version| 
              'Open' if version.reify.class == Ticket and version.reify.status.name == 'Open'
            }.compact

            if opened_versions.size > 0
               rawtext ' (+)' 
            end
        end
      end
  end
end
