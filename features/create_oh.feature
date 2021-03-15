Feature: Create a office hours session

  As a TA
  So that I may easily and orderly host office hours for my beloved students
  I want to create a queue for them

Background: user exists
  Given the following user exists:
  | email               | password  |
  | ta6969@colombia.edu | Roblox!69 |

Scenario: create an office hours
  When I go to the OH create page
  Then I should be on "Log in"
  When I fill in the following:
      | Email     | ta6969@colombia.edu |
      | Password  | Roblox!69           |
  And I press "Log in"
  Then I should be on the OH create page
  When I fill in the following:
      | Name      | TA-kun                   |
      | Class     | Underwater Basketweaving |
      | Time      | 5:00PM                   |
      | Zoom Info | http://zo.om             |
  And  I press "Create OH"
  Then I should be on the home page
  And I should see "Underwater Basketweaving" OH for TA-kun"
