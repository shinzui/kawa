Feature: Manage bookmarks

  Scenario: Adding a new bookmark
    Given I create a new bookmark
    Then I should see the bookmark

  Scenario: Adding a private bookmark
    Given I create a private bookmark
    Then I should see the bookmark
    And the bookmark should be private
