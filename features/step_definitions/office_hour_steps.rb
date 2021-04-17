Given /the following office hour(?:s)? exist/ do |oh_table|
  oh_table.hashes.each do |oh|
    OfficeHour.create!(oh)
  end
end

Given /the following chat(?:s)? exist/ do |chat_table|
  chat_table.hashes.each do |chat|
    Chat.create(chat)
  end
end

Given /the following queue entry exists/ do |qe_table|
  qe_table.hashes.each do |qe|
    QueueEntry.create(qe)
  end
end

Given /office hour (\d+) is (active|inactive)/ do |office_hour_id, active|
  oh = OfficeHour.find(office_hour_id)
  oh.active = active == "active"
  oh.save!
end

When /I follow the data-confirmed (.*) button/ do |name|
  accept_confirm do
    click_link name
  end
end

Given /I save and open page/ do
  save_and_open_page
end

Then /(.*) seed office hours should exist/ do | n_seeds |
  OfficeHour.count.should be n_seeds.to_i
end

And /^(?:|I )enter "(.*)" as my name and join/ do |name|
  fill_in('displayName', :with => name)
  click_button('Join')
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  if page.body.include?(e1)
    if !page.body.split(e1, 2)[1].include?(e2)
      fail "#{e1} not before #{e2}"
    end
  else
    fail "#{e1} not present"
  end
  
end

Then /I should see all office hours/ do
  # Make sure that all the movies in the app are visible in the table
  OfficeHour.all.each do |m|
    page.should have_content(m.host)
    # assert page.has_content?(m.title)
  end
end
