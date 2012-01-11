Feature: Page tags

  Scenario: Adding tags through the tag plugin
    Given I create a page and tag it with "tokyo tower, 東京"
    Then it should have the "tokyo tower" tag
    And it should have the "東京" tag
  
