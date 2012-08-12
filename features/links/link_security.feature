Feature: Link Security

  Scenario: Viewing private links
    Given there is a private "link" to "http://daum.net/" created by "yuni@gmail.com" 
    And I am logged in as "juah@gmail.com"
    And I access "http://daum.net/" link
    Then I should be redirected to the homepage

  Scenario: Viewing index page
    Given there is a private "link" to "http://daum.net/" created by "yuni@gmail.com" 
    And I am logged in as "juah@gmail.com"
    And I go the link index page
    Then I should not see a link to "http://daum.net/"
