Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create!({
             :email => user[:email],
             :password => user[:password],
             :password_confirmation => user[:password]
           })
  end
end

# Then /I should be on (.+)/ do |page_name|
#   expect(page).to have_current_path(path_to(page_name))
# end

# When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
#   rating_list.split(', ').each do |rating|
#     step %{I #{uncheck.nil? ? '' : 'un'}check "ratings_#{rating}"}
#   end
# end

# Then /I should see all the movies/ do
#   # Make sure that all the movies in the app are visible in the table
#   Movie.all.each do |movie|
#     step %{I should see "#{movie.title}"}
#   end
# end

# Then /the director of "(.*)" should be "(.*)"/ do |t, d|
#   expect(Movie.find_by(title: t).attributes[:director] == d)
# end
