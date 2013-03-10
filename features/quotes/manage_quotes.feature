@quotes
Feature: Manage quotes

  Background:
    Given A logged in user

  Scenario: Adding a new quote
    Given I create a new quotation
    Then I should see the quotation
    And I should be the contributor to the quotation

  Scenario: Adding a new quote in a different language
    Given I create a "Japanese" quotation
    Then the quote should be marked with the "ja" lang

  @update_quote
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

