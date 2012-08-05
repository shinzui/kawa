@view_pages
Feature: View pages

  Scenario: Access page by friendly name
    Given there is a "tokyo tower" Page
    Then I should be able to access the page from a user friendly url

  @logged_in
  Scenario: Accessing non-existing page
    Given I access the "銀座" page
    Then I should be redirected to the create "銀座" page

  @logged_in
  Scenario: Accessing non-existing page which has space in name
    Given I access the "Inari Taisha" page
    Then I should be redirected to the create "Inari Taisha" page

  Scenario: Access unicode named page by friendly name
    Given there is a "日本" Page
    Then I should be able to access the page from a user friendly url

  Scenario: View list of pages
    Given there are 3 Pages
    And there is a "日本" Page
    And I go to the index page
    Then I should see a link to all pages
