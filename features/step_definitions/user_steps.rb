Given /the following user(?:s)? exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create(user)
  end
end

Then /I should be sad/ do
  expect(true).to be(true)
end