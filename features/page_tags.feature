Feature: Page tags

  Scenario: Adding tags through the tag plugin
    Given I create a page and tag it with "tokyo tower, 東京"
    Then it should have the "tokyo tower" tag
    And it should have the "東京" tag
  
  Scenario: Viewing pages tagged with a specific tag
    Given the "tokyo tower" page is tagged with "tokyo"
    And there are 2 Pages
    When I visit the "tokyo" tag page
    Then I should a link to the "tokyo tower" page

  Scenario: Viewing tag page
    Given the "tokyo tower" page is tagged with "tokyo"
    And the "namba" page is tagged with "osaka"
    When I visit the page tags page
    Then I should see a link to the "tokyo" tag page
    And I should see a link to the "osaka" tag page