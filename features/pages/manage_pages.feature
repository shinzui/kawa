Feature: Manage pages

  Scenario: Create new page with markdown
    Given I am logged in as "ozu@gmail.com"
    And I create a "Tokyo Monogatari" page in "markdown"
    Then I should see the page generated
    And I should be the author of the page
    And the page links should not be private

  @logged_in
  Scenario: Create new private page
   Given I create a private "Banshun" page in "markdown"
   Then I should see the page generated
   And the page should be private
   And the page links should be private

  @logged_in
  Scenario: Create a private page containing existing link
    Given I create an "Ozu Yasujiro" page with the following links:
     | title          | url                                            |
     | wikipedia page | http://en.wikipedia.org/wiki/Yasujir%C5%8D_Ozu |
     | tokyo boshoku  | http://en.wikipedia.org/wiki/Tokyo_Twilight    |
    And I create a private "Tokyo Boshoku" page with the following links:
     | title         | url                                         |
     | tokyo boshoku | http://en.wikipedia.org/wiki/Tokyo_Twilight |
    Then the "http://en.wikipedia.org/wiki/Tokyo_Twilight" link should be "public"

  @logged_in
  Scenario: Updating a page's name
    Given there is an "Inari Taisha" Page
    And I update the Page name to "Fushimi Inari Taisha"
    Then the Page name should change

  @logged_in
  Scenario: Deleting a page
    Given there is a "神戸" Page
    Then I should be able to delete the page
