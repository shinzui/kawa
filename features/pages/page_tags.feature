Feature: Page tags

  @logged_in
  Scenario: Adding tags through the tag plugin
    Given I create a page and tag it with "tokyo tower, 東京"
    Then it should have the "tokyo tower" tag
    And it should have the "東京" tag
  
  Scenario: Viewing pages tagged with a specific tag
    Given the "tokyo tower" page is tagged with "tokyo"
    And there are 2 Pages
    When I visit the "tokyo" tag page
    Then I should see a link to the "tokyo tower" page

  @private_tag_search
  Scenario: Viewing private pages tagged with a specific tag
    Given there is a "北海道" private page created by "ayaka@gmail.com"
    And the page is tagged with "hokkaido"
    And I am logged in as "yu@gmail.com"
    When I visit the "hokkaido" tag page
    Then I should not see a link to the "北海道" page

  Scenario: Viewing pages tagged with multiple tags
    Given the "tokyo tower" page is tagged with "tokyo, landmark"
    And there are 2 Pages
    When I visit the "tokyo and landmark" tag page
    Then I should see a link to the "tokyo tower" page

  @javascript
  Scenario: Viewing tag page
    Given the "tokyo tower" page is tagged with "tokyo"
    And the "namba" page is tagged with "osaka"
    When I visit the page tags page
    Then I should see a link to the "tokyo" tag page
    And I should see a link to the "osaka" tag page
