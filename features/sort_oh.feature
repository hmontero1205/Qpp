Feature: display list of office hours sorted by different criteria

  As an avid office-hour-goer
  So that I can quickly browse office hours based on my preferences
  I want to see offices sorted by host, class name, or time

  Background: movies have been added to database
    Given the following users exist:
      | id | email                 | password     |
      | 1  | ta6969@columbia.edu   | memexD       |
      | 2  | senpai<3@columbia.edu | uwuOwO       |
      | 3  | monke@banana.edu      | stinky       |
      | 4  | us@homeboys.edu       | robloxmemexD |

    Given the following office hour exists:
      | id | host   | class_name                     | starts_on | ends_on | zoom_info    | user_id |
      | 1  | TA-kun | Underwater Basketwelding       | 5:00PM    | 6:00PM  | http://zo.om | 1       |
      | 2  | Senpai | Advanced Anime Studies         | 4:20PM    | 5:20PM  | http://zo.om | 2       |
      | 3  | Monke  | Life in the Jungle             | 5:40PM    | 6:40PM  | http://zo.om | 3       |
      | 4  | Us     | Beginning Software Engineering | 3:00PM    | 4:00PM  | http://zo.om | 4       |

    And I am on the Q++ home page
    Then 4 seed office hours should exist

  Scenario: sort office hours by host
    When I follow "Host"
    Then I should see "Monke" before "Senpai"
    Then I should see "Senpai" before "TA-kun"
    Then I should see "TA-kun" before "Us"

  Scenario: sort office hours by class name
    When I follow "Class Name"
    Then I should see "Senpai" before "Us"
    Then I should see "Us" before "Monke"
    Then I should see "Monke" before "TA-kun"

  Scenario: sort office hours by time
    When I follow "When"
    Then I should see "Us" before "Senpai"
    Then I should see "Senpai" before "TA-kun"
    Then I should see "TA-kun" before "Monke"