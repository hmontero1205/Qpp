Feature: Log into the app

  As a TA
  so that I can manage my office hours
  I want to log in!

  Background: user exists
    Given the following users exist:
      | email               | password | name        |
      | ta6969@columbia.edu | memexD   | RobloxFiend |

  Scenario: log in with a bad credentials
    Given I log in with "noexist@example.com" and "password"
    Then I should see "Invalid"
    And I should be on the log in page

  Scenario: log in with good credentials
    Given I log in with "ta6969@columbia.edu" and "memexD"
    Then I should be on the home page
