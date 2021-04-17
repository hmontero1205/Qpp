Feature: Join the Zoom call directly from the OH page
  As a human person
  So that I can discuss my coursework with other students and get help from the TA
  I want to join the Zoom chat and discuss

  Background: office hour exists
    Given the following user exists:
      | id | email               | password |
      | 1  | ta6969@columbia.edu | memexD   |

    Given the following office hour exists:
      | id | host   | class_name               | starts_on | ends_on | zoom_info    | meeting_id | meeting_passcode | user_id |
      | 1  | TA-kun | Underwater Basketwelding | 5:00PM    | 6:00PM  | http://zo.om | 1          | 1                | 1       |


  @javascript
  Scenario: I join the office hour and connect to Zoom
    When I go to the home page
    And office hour 1 is active
    And I follow "See more"
    And I enter "Evan" as my name and join
#    Then I should see "Join Zoom"
    And I press "Join Zoom" inside the zoom-iframe frame

  @javascript
  Scenario: I join the office hour as a logged-in user
    Given I log in with "ta6969@columbia.edu" and "memexD"
    When I go to the home page
    And office hour 1 is active
    And I follow "See more"
    And I press "Join Zoom" inside the zoom-iframe frame
