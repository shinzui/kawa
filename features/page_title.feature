Feature: Page title

  Scenario: Default page title
    Given there is an "Akita" Page
    And I access the "Akita" page
    Then the page header should be "Akita"
    And the page title should be "川 - Akita"

  Scenario: Page with header
    Given the page:
      |name       | raw_data| markup  |
      |Lake Tazawa| #田沢湖 | markdown|
    And I access the "Lake Tazawa" page
    Then the page header should be "田沢湖"
    And the page title should be "川 - 田沢湖"
