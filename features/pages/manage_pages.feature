Feature: Manage pages

  Background:
   Given A logged in user

  Scenario: Create new page with markdown
    Given I create a "japan" page in "markdown"
    Then I should see the page generated

  # Scenario: Create new page with creole
    # Given I create a "tokyo" page in "creole"
    # Then I should see the page generated

  Scenario: Updating a page's name
    Given there is an "Inari Taisha" Page
    And I update the Page name to "Fushimi Inari Taisha"
    Then the Page name should change

  Scenario: Deleting a page
    Given there is a "神戸" Page
    Then I should be able to delete the page
