Feature: Manage pages

  Scenario: Create new page with markdown
    Given I am logged in as "ozu@gmail.com"
    And I create a "Tokyo Story" page in "markdown"
    Then I should see the page generated
    And I should be the author of the page

  # Scenario: Create new page with creole
    # Given I create a "tokyo" page in "creole"
    # Then I should see the page generated

  @logged_in
  Scenario: Updating a page's name
    Given there is an "Inari Taisha" Page
    And I update the Page name to "Fushimi Inari Taisha"
    Then the Page name should change

  @logged_in
  Scenario: Deleting a page
    Given there is a "神戸" Page
    Then I should be able to delete the page
