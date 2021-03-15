

# Then /^(?:|I )go to $/ do 
#   visit path_to(page_name)
# end

# Given /the following movies exist/ do |movies_table|
#   movies_table.hashes.each do |movie|
#     Movie.create movie
#   end
# end

Then /I should be on (.+)/ do |page_name|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page).to have_current_path(path_to(page_name))
end

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
