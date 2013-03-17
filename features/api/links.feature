@api
Feature: Links JSON service
  As an api user
  Kawa should
  Provide a resource to get links' information


  Scenario: GET a link resource
    Given there is a Link with a URL screenshot
    # And I send and accept JSON
    And I send a GET request for "/links/1.json"
    Then the response status should be "200"
    And the JSON response should have the "link" object with following attributes:
      |attribute|
      |id|
      |url|
      |url_screenshot|
      |url_screenshot_thumb|

  Scenario: GET a private link resource
    Given there is a private "link" to "http://daum.net/" created by "yuni@gmail.com" 
    # And I send and accept JSON
		And I send a GET request for "/links/1.json"
    Then the response status should be "401"
    



