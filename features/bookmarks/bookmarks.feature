Feature: Viewing bookmarks

  Scenario: Bookmark ordering
    Given there are 3 bookmakrs
    And I update the first bookmark
    And I go to view all bookmarks
    Then the bookmarks should be reversed ordered by their creation date
