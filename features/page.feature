Feature: Manage pages

Scenario: Create new page with markdown
    Given I create a "japan" page in "markdown"
    Then I should see the "japan" page generated from "markdown"

Scenario: Create new page with creole
    Given I create a "tokyo" page in "creole"
    Then I should see the "tokyo" page generated from "creole"

Scenario: Access page by friendly name

