Feature: Manage user profile

  Scenario: Editing own profile
    Given there is a user "ozu@gmail.com"
    And "ozu@gmail.com" is logged in
    And he edits his profile
    Then the user profile should get updated

