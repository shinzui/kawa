Feature: Page security

  Scenario: Viewing private pages
    Given there is an "atami" private page created by "ayaka@gmail.com"
    And I am logged in as "hitomi@gmail.com"
    And I access the "atami" page
    Then I should be redirected to the homepage

  Scenario: Viewing index page
    Given there is an "atami" private page created by "ayaka@gmail.com"
    And I am logged in as "hitomi@gmail.com"
    And I go to the index page
    Then I should not see a link to the "atami" page
    
