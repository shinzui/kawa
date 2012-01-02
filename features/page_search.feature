Feature: Page Search

	@javascript
	Scenario: Search for page by name
		Given there is a "Rainbow bridge" Page
		And there are 3 Pages
		And I search for "bridge"
		Then I should get a link to the "Rainbow bridge" page

  @javascript
	Scenario: Search with invalid query parameters
		Given there is a "あき" Page
		And  I search for "]("
		Then I should see a friendly search error page
