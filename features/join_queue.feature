Feature: Join an office hours session
  As a confused student
  So that I can try to get the TA to give me the homework answers
  I want to join the queue to ask my questions

  Background: office hour exists
    Given the following user exists:
      | id | email               | password    |
      | 1  | ta6969@columbia.edu | Roblox!69XD |

    Given the following office hour exists:
      | id | host   | class_name               | time   | zoom_info    | user_id |
      | 1  | TA-kun | Underwater Basketwelding | 5:00PM | http://zo.om | 1       |

  Scenario: Office hour hasn't started yet
    Given it is currently "4:00 pm"
    And office hour 1 is inactive
    When I go to the home page
    And I follow "See more"
    Then I should see "This OH is not currently active"
    And I should be sad

  @javascript
  Scenario: User joins the queue
    Given it is currently "5:05 pm"
    And office hour 1 is active
    When I go to the home page
    And I follow "See more"
    Then I should see "Enqueue yourself!"
    Then I fill in "Curious George" for "Name"
    And I fill in "LET ME IN" for "Description"
    And I press "Submit"
    Then I should see "LET ME IN"

  @javascript
  Scenario: TA can remove users that are enqueued
    # Log in first
    Given office hour 1 is active
    Given I log in with user "ta6969@columbia.edu" and password "Roblox!69XD"

    And I go to the home page
    And I follow "See more"
    Then I should see "Enqueue yourself!"
    And I fill in "RobloxFiend" for "Name"
    And I fill in "I am your TA" for "Description"
    And I press "Submit"
    Then I should see "RobloxFiend"
    When I press "X"
    Then I should not see "RobloxFiend"

  @javascript
  Scenario: TA can activate and deactivate Office Hours
    Given I log in with user "ta6969@columbia.edu" and password "Roblox!69XD"
    And I go to the home page
    And I follow "See more"
    Then I should see "This OH is not currently active"
    Then I follow "Activate"
    And I should see "Enqueue yourself!"
    Then I follow "Deactivate"
    And I should see "This OH is not currently active"
