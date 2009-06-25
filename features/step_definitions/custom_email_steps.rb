When /^I receive an email$/ do
  open_email(current_email_address)
end

When /^I open the most recent email$/ do
  open_last_email
end

When /^I should have (\d+) emails$/ do |n|
  mailbox_for(current_email_address).size.should == n.to_i
end
