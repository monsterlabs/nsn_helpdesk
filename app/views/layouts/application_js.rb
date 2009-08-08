class Views::Layouts::ApplicationJs < Views::Layouts::Page
  include AuthenticationSystem

  def content
    js_content
  end  
end
