Sham.login { InternetForgery.user_name }
Sham.password { BasicForgery.password }
Sham.email { InternetForgery.email_address }

User.blueprint do
  pwd = Sham.password
  login
  email
  password { pwd }
  password_confirmation { pwd }
end
