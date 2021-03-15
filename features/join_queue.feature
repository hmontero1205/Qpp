Feature: Join an office hours session
  As a confused student
  So that I can try to get the TA to give me the homework answers
  I want to join the queue to ask my questions

  Background: office hour exists
    Given the following user exists:
      | id | email               | password  |
      | 1  | ta6969@colombia.edu | Roblox!69 |

    Given the following office hour exists:
      | id | host   | class_name               | time   | zoom_info    | user_id |
      | 1  | TA-kun | Underwater Basketwelding | 5:00PM | http://zo.om | 1       |

  Scenario:
    Given it is currently "4:00 pm"
    And office hour 1 is inactive
    When I go to the home page
    And I follow "See more"
    Then I should see "This OH is not currently active"
    And I should be sad

  Scenario:
    Given it is currently "5:05 pm"
    And office hour 1 is active
    When I go to the home page
    And I follow "See more"
    Then I should see "Enqueue yourself!"