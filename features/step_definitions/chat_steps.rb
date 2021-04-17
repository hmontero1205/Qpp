When /I send the message "(.*)"/ do |msg|
  within "#thread-tools" do
    fill_in("Message", :with => msg)
    click_button("Send")
  end
end
