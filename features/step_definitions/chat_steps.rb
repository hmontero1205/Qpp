When /I send a message with name "(.*)" and message "(.*)"/ do |name, msg|
  within "#thread-tools" do
    fill_in("Name", :with => name)
    fill_in("Message", :with => msg)
    click_button("Send")
  end
end
