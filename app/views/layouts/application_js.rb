class Views::Layouts::ApplicationJs < Views::Layouts::Page
  include AuthenticationSystem

  def content
    controller_setup
    js_content
  end  
end
