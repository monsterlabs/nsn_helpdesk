require 'machinist/active_record'
require 'forgery'
# Temporary Forgery reference: http://github.com/sevenwire/forgery/tree/1c00079ca0bbf74465b3d0b31c74d09e38bea2d2/lib/forgeries

User.blueprint do
  pwd = BasicForgery.password
  login { InternetForgery.user_name }
  email { InternetForgery.email_address }
  password { pwd }
  password_confirmation { pwd }
end


Role.blueprint do
  name { LoremIpsumForgery.word }
end

Status.blueprint do
  name { LoremIpsumForgery.word }
end

Region.blueprint do
  name { LoremIpsumForgery.word }
end

Failure.blueprint do
  title { LoremIpsumForgery.sentence }
end