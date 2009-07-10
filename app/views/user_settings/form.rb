class Views::UserSettings::Form < Erector::RailsWidget
  needs :f, :record
  
  def content
    div do
    widget Views::Admin::Users::User, :f => f  
     widget Views::Admin::Users::Person, :f => f, :user => @record

    end
  end
  
end