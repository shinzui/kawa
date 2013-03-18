@signing_in
Feature: Signing in to the application

  Scenario: Signing in with valid credentials
    Given I visit the sign in page
    And I enter valid credentials
    Then I should be redirected to the homepage
    And I should be signed in

