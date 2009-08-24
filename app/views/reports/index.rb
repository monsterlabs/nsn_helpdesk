class Views::Reports::Index < Views::Layouts::Application

  js 'swfobject'

  def page_title
    "Reports Index"
  end

  def view_content
    br
    br
    h1 "Cases by Region"
    br
    rawtext error_messages_for 'report', :class => 'ui-state-error ui-corner-all'
     div :class => "grid_16" do
       span :class => 'clear'
       form_for(:report, :url => {:action => 'create'}) do
         div :class => "grid_5 prefix_1" do
           b "Case type" 
           br
           br
           check_box_tag 'report[priorities][]', '1'
           text 'Emergencies'
           br
           check_box_tag 'report[priorities][]', '2'
           text 'Corrective manteinance (Medium)'
           br
           check_box_tag 'report[priorities][]', '3'
           text 'Corrective manteinance (High)'
           
         end
     
         div :class => "grid_2", :style => 'margin-left: -35px;' do
           b "Regions" 
           br
           br
           rawtext select :report, :region_id, (options_for_select Region.all.collect {|record| [record.name, record.id]}), {}, {:multiple => true, :size => 9}
         end
    
         div :class => "grid_2" do
           b "Months" 
           br
           br
           rawtext select (:report, :months, [ ['January', '1'], ['February', '2'], ['March', '3'], ['April', '4'], ['May', '5'], ['June', '6'],
                                               ['July', '7'], ['August', '8'], ['September', '9'], ['October', '10'], ['November', '11'], ['December', '12'] ],
                                            {}, {:multiple => true, :size => 9})
         end
    
         div :class => "grid_2" do
           b "Year" 
           br
           br
           rawtext select :report, :year, (2009..(Date.today.year + 5)).collect { |y| [y, y]}
         end
    
         div :class => 'clear'
         br
         rawtext submit_tag "Get report", ui_style(:button)
       end

     end
     br :class => 'clear'
     hr
     br
     h1 'All cases'
     br
       rawtext error_messages_for 'report', :class => 'ui-state-error ui-corner-all'
        div :class => "grid_16" do
          span :class => 'clear'
          form_for(:report, :url => {:action => 'report_all'}, :method => :put) do
            div :class => "grid_5 prefix_1" do
              b "Case type" 
              br
              br
              check_box_tag 'report[priorities][]', '1'
              text 'Emergencies'
              br
              check_box_tag 'report[priorities][]', '2'
              text 'Corrective manteinance (Medium)'
              br
              check_box_tag 'report[priorities][]', '3'
              text 'Corrective manteinance (High)'

            end

            div :class => "grid_2" do
              b "Months" 
              br
              br
              rawtext select (:report, :months, [ ['January', '1'], ['February', '2'], ['March', '3'], ['April', '4'], ['May', '5'], ['June', '6'],
                                                  ['July', '7'], ['August', '8'], ['September', '9'], ['October', '10'], ['November', '11'], ['December', '12'] ],
                                               {}, {:multiple => true, :size => 9})
            end

            div :class => "grid_2" do
              b "Year" 
              br
              br
              rawtext select :report, :year, (2009..(Date.today.year + 5)).collect { |y| [y, y]}
            end

            div :class => 'clear'
            br
            rawtext submit_tag "Get report", ui_style(:button)
          end

        end
  end
    
end
