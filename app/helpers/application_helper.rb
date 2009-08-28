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
end
