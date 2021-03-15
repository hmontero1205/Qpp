# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the (OH )?home\s?page$/ then '/office_hours'
    when /^the (OH )?create\s?page$/ then '/office_hours/new'
    when /^the log in page$/ then '/users/sign_in'

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      # begin
      #   page_name =~ /^the (.*) page for "(.*)"$/
      #   if $1 == "edit"
      #     edit_movie_path(Movie.find_by(title: $2))
      #   elsif $1 == "details"
      #     movie_path(Movie.find_by(title: $2))
      #   elsif $1 == "Similar Movies"
      #     search_directors_path(Movie.find_by(title: $2))
      #   end
      # rescue ArgumentError
      #   raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
      #     "Now, go and add a mapping in #{__FILE__}"
      # end
    end
  end
end

World(NavigationHelpers)
