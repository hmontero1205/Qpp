When /I send the message "(.*)"/ do |msg|
  within "#thread-tools" do
    fill_in("Message", :with => msg)
    click_button("Send")
  end
end


And /the "([^"]*)" button should be (.*)$/ do |button, color|
  if button =~ /\+/
    class_name = find('.thread-btn')[:class]
    if color == "yellow"
      class_name.should =~ /btn-warning/
    end
  end
end
