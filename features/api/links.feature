@api
Feature: Links JSON service
  As an api user
  Kawa should
  Provide a resource to get links' information

  Scenario: GET a private link resource
    Given there is a private "link" to "http://daum.net/" created by "yuni@gmail.com"
    # And I send and accept JSON
		And I send a GET request for "/links/1.json"
    Then the response status should be "401"
    



