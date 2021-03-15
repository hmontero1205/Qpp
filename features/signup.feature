Feature: Sign up for OH

  As a TA
  So that I may easily and orderly host office hours for my beloved students
  I want sign up for the esteemed SaaS Q++

Background:

Scenario: sign up
  When I go to the home page
  Then I should not see "Signed in as ta6969@colombia.edu"
  And I follow "Sign up"
  Then I should be on the sign up page

  When I fill in "Email" with "ta6969@colombia.edu"
  When I fill in "Password" with "Roblox!69XD"
  When I fill in "Password confirmation" with "Roblox!69XD"
  And I press "Sign up"

  Then I should be on the home page
  And I should see "Logged in as ta6969@colombia.edu" 
  And I should see "Add new OH"