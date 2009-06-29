class Views::Admin::Users::Form < Erector::RailsWidget
  needs :f, :user
  
  def content
    widget Views::Admin::Users::Person, :f => f, :user => user
    widget Views::Admin::Users::User, :f => f
  end
  
end