Feature: Manage pages

  Scenario: Create new page with markdown
      Given I create a "japan" page in "markdown"
      Then I should see the page generated

  Scenario: Create new page with creole
      Given I create a "tokyo" page in "creole"
      Then I should see the page generated

  Scenario: Updating a page's name
      Given there is an "Inari Taisha" Page
      And I update the Page name to "Fushimi Inari Taisha"
      Then the Page name should change

  Scenario: Access page by friendly name
      Given there is a "tokyo tower" Page
      Then I should be able to access the page from a user friendly url

  Scenario: Access unicode named page by friendly name
      Given there is a "日本" Page
      Then I should be able to access the page from a user friendly url

  Scenario: View list of pages
      Given there are 3 Pages
      And there is a "日本" Page
      And I go to the index page
      Then I should see a link to all pages

  Scenario: Deleting a page
      Given there is a "神戸" Page
      Then I should be able to delete the page
