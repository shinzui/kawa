Feature: Manage quotes

  Scenario: Adding a new quote
    Given I create a new quotation
    Then I should see the quotation

  Scenario: Adding a new quote in a different language
    Given I create a "Japanese" quotation
    Then the quote should be marked with the "ja" lang

  Scenario: Editing a quote
    Given there is a quote
    And I update quotation to "Step by step walk the thousand-mile road"
    Then the quotation should change

  Scenario: Deleting a quote
    Given there is a quote
    Then I should be able to delete the quote

  Scenario: Tagging a quote
    Given there is a quote
    And I tag the quote with "japan, wisdom"
    Then the quote should be tagged with "japan and wisdom"

  Scenario: Viewing all quotes
    Given there are 4 quotes
    And I go to quotes page
    Then I should see the quotes

  Scenario: Viewing tagged quotes
    Given a quote tagged with "japan"
    And there are 2 quotes
    When I visit the "japan" tag quotes
    Then I should see the "japan" tagged quote
