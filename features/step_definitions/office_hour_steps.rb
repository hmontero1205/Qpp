Given /the following office hour(?:s)? exist/ do |oh_table|
  oh_table.hashes.each do |oh|
    OfficeHour.create(oh)
  end
end

Given /office hour (\d) is (active|inactive)/ do |office_hour_id, active|
  oh = OfficeHour.find(office_hour_id)
  oh.active = active == "active"
  oh.save!
end

When /I follow the data-confirmed (.*) button/ do |name|
	accept_confirm do
	  click_link name
	end
end