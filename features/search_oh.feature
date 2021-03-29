Feature: display list of office hours filtered by search term

  As a concerned student
  So that I can quickly browse office hours that I need to attend
  I want to be able to search for specific OH and/or TAs

Background: office hours have been added to database
  Given the following users exist:
  | id | email               | password    |
  | 1  | ta6969@columbia.edu | memexD |
  | 2  | senpai<3@columbia.edu | uwuOwO |
  | 3  | monke@banana.edu | stinky |
  | 4  | us@homeboys.edu | robloxmemexD |

  Given the following office hours exist:
  | id | host   | class_name               | time   | zoom_info    | user_id |
  | 1  | TA-kun | Underwater Basketwelding | 5:00PM | http://zo.om | 1       |
  | 2  | Senpai | Advanced Anime Studies | 4:20PM | http://zo.om | 2       |
  | 3  | Monke | Life in the Jungle | 5:40PM | http://zo.om | 3       |
  | 4  | Us | Beginning Software Engineering | 3:00PM | http://zo.om | 4       |

  And I am on the Q++ home page
  Then 4 seed office hours should exist

Scenario: search for host
  Given I fill in "search_search" with "Monke"
  And press "Search"
  Then I should see "Monke"
  And I should not see "Senpai"
  And I should not see "TA-kun"
  And I should not see "Us"

Scenario: search for class
  Given I fill in "search_search" with "Life"
  And press "Search"
  Then I should see "Monke"
  And I should not see "Senpai"
  And I should not see "TA-kun"
  And I should not see "Us"

Scenario: clear filters
  Given I fill in "search_search" with "Life"
  And press "Search"
  Then I should see "Monke"
  And I should not see "Senpai"
  And I should not see "TA-kun"
  And I should not see "Us"
  And I follow "Clear search"
  Then I should see all office hours
