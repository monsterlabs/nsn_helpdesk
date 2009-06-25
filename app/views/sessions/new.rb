require "#{RAILS_ROOT}/app/views/layouts/form"

class Views::Sessions::New < Views::Layouts::Page
  # needs :article

  def content
    # widget Form, :action => "/session" do
    #   table = LabelTable.new(:title => "New Comment") do |table|
    #     table.field("login") do
    #       textfield :name => "login"
    #     end
    #     table.button do
    #       input :type => "submit", :name => "submit", :value => "Sign In"
    #     end
    #   end
    #   widget table
    # end
    form_for @session, :session, :url => session_path do |f|
      rawtext f.label "Login"
      rawtext f.text_field :login
      rawtext f.label "Password"
      rawtext f.password_field :password
      rawtext submit_tag "Sign In"
    end
  end
  
end