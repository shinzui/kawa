@quotes
Feature: View quotes
  Scenario: Viewing all quotes
    Given there are 4 quotes
    And I go to quotes page
    Then I should see the quotes

  Scenario: Viewing tagged quotes
    Given a quote tagged with "japan"
    And there are 2 quotes
    When I visit the "japan" tag quotes
    Then I should see the "japan" tagged quote
