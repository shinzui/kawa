Feature: Page Markup

  Background:
    Given A logged in user

	Scenario: Interwiki Link to existing page
		Given there is a "Tokyo Tower" Page
		And I create an interwiki link to "it" from the "Tokyo" Page
		Then I should see a link to the "Tokyo Tower" page on the "Tokyo" page 
	
	Scenario: Interwiki Link to non-existing page
		Given I create an interwiki link to "Omotesando Hills" from the "Tokyo" Page
		Then I should see a link to the "Omotesando Hills" page on the "Tokyo" page
