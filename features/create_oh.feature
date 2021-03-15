Feature: Create a office hours session

  As a TA
  So that I may easily and orderly host office hours for my beloved students
  I want to create a more perfect queue for them

Background: user exists
  Given the following users exist:
  | email               | password    |
  | ta6969@colombia.edu | memexD |

Scenario: create an office hours
  When I go to the OH create page
  Then I should be on the log in page
  When I fill in "Email" with "ta6969@colombia.edu"
  When I fill in "Password" with "memexD"
  And I press "Log in"

  Then I should be on the OH create page
  When I fill in "office_hour_host" with "TA-kun"
  And I fill in "office_hour_class_name" with "Underwater Basketweaving"
  And I fill in "office_hour_time" with "4:20PM"
  And I fill in "office_hour_zoom_info" with "https://roblox.com"
  And I press "Save Changes"
  Then I should be on the home page
  And I should see "Underwater Basketweaving" 
  And I should see "TA-kun"
