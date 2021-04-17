Feature: Log into the app

  As a TA
  so that I can manage my office hours
  I want to log in!

Background: user exists
  Given the following users exist:
  | email               | password | name |
  | ta6969@colombia.edu | memexD | RobloxFiend |

Scenario: create an office hours
  Given I log in with "noexist@example.com" and "password"
  Then I should see "Invalid"
  And I should be on the log in page
