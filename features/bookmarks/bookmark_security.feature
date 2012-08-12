Feature: Bookmark Security

  Scenario: Viewing private bookmakrs
    Given there is a private "bookmark" to "http://naver.com/" created by "yuni@gmail.com" 
    And I am logged in as "juah@gmail.com"
    And I access "http://naver.com/" bookmark
    Then I should be redirected to the homepage

  Scenario: Viewing all bookmarks 
    Given there is a private "bookmark" to "http://naver.com/" created by "yuni@gmail.com" 
    And I am logged in as "juah@gmail.com"
    And I go to view all bookmarks
    Then I should not see a link to "http://naver.com/"

