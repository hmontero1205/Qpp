Feature: Create a office hours session

  As a TA
  So that I may easily and orderly host office hours for my beloved students
  I want to delete an old and outdated OH

  Background: user and oh exists
    Given the following user exists:
      | id | email               | password |
      | 1  | ta6969@colombia.edu | memexD   |

    Given the following office hour exists:
      | id | host   | class_name               | starts_on | ends_on | zoom_info    | meeting_id | meeting_passcode | user_id |
      | 1  | TA-kun | Underwater Basketwelding | 5:00PM    | 6:00PM  | http://zo.om | 1 | 1 | 1       |

  Scenario: delete an office hours
    When I go to the home page
    Then I go to the log in page
    When I fill in "Email" with "ta6969@colombia.edu"
    When I fill in "Password" with "memexD"
    And I press "Log in"

    Then I should be on the home page
    Then I follow "See more"
    Then I should be on the office hour 1 page
    When I follow "Delete"
    Then I should be on the home page
    And I should see "TA-kun's Underwater Basketwelding OH was successfully deleted."
    And I should not see "See more"

  Scenario: delete an office hour while not logged in
    When I go to the home page
    Then I follow "See more"
    Then I should be on the office hour 1 page
    And I should not see "Delete"
