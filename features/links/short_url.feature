Feature: Short Url

  @javascript 
  Scenario: Viewing a short url
    Given there is a Link
    And I visit the link short url
    Then I should be redirected to the link's url

  @javascript
  Scenario: Record the visit
    Given there is a Link
    And I visit the link short url
    Then I should record the visit to the link

