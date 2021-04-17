Feature: Chat while you're waiting the queue
  As a student working on an assignment
  So that I can try to get answers to my questions faster
  So that I can help other students get answers to their questions faster
  I want to be able to chat with them while I wait

  Background: office hour exists
    Given the following user exists:
      | id | email               | password |
      | 1  | ta6969@columbia.edu | memexD   |

    Given the following office hour exists:
      | id | host   | class_name               | starts_on | ends_on | zoom_info    | meeting_id | meeting_passcode | user_id |
      | 1  | TA-kun | Underwater Basketwelding | 5:00PM   | 6:00PM  | http://zo.om | 1 | 1 | 1       |

    Given the following queue entry exists:
      | id  | student     | description  | creator_id | office_hour_id |
      | 100 | Evan-senpai | Please help! | 12345      | 1              |

    Given the following chats exist:
      | id  | name | msg                 | office_hour_id | queue_entry_id |
      | 100 | Hans | Did you try Google? | 1              | 100            |

  @javascript
  Scenario: User views an ongoing chat
    Given it is currently "5:05 pm"
    And office hour 1 is active
    When I go to the home page
    And I follow "See more"
    And I fill in "displayName" with "Evan"
    And I press "Join"
    Then I should see "Evan-senpai"
    When I press "+1"
    Then I should see "Did you try Google?"
    And the "+1" button should be yellow

  @javascript
  Scenario: User contributes to an ongoing chat
    Given it is currently "5:05 pm"
    And office hour 1 is active
    When I go to the home page
    And I follow "See more"
    And I fill in "displayName" with "Evan"
    And I press "Join"
    Then I should see "Evan-senpai"
    When I press "+1"
    Then I should see "Did you try Google?"
    When I send the message "that didn't help"
    Then I should see "that didn't help"
    And I should see "+2"
