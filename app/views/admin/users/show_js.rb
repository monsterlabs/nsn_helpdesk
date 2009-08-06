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
    p do
      b { text "Business phone"}
      text @user.address.business_phone
    end
    p do
      b { text "Home phone"}
      text @user.address.home_phone
    end
    p do
      b { text "Mobile phone"}
      text @user.address.mobile_phone
    end
  end
end