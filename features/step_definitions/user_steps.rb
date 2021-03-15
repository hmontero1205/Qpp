Given /the following user(?:s)? exist(?:s)?/ do |users_table|
  users_table.hashes.each do |user|
    User.create(user)
  end
end

Then /I should be sad/ do
  expect(true).to be(true)
end

Then /I should sleep (\d+) seconds/ do |seconds|
  sleep seconds
end

Given /I log in with user "(.*)" and password "(.*)"/ do |user, pass|
  visit path_to("the log in page")
  fill_in("Email", :with => user)
  fill_in("Password", :with => pass)
  click_button("Log in")
  expect(page).to have_content("Signed in successfully.")
end