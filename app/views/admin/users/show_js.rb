class Views::Admin::Users::ShowJs < Views::Layouts::ApplicationJs
  def js_content
    p do
      b { text "Company"}
      text @user.person.company.name
    end
    p do
      b { text "Email"}
      text @user.email
    end
  end
end