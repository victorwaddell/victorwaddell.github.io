Feature: View Items for Customer
  As a customer
  I want to be able to view item lists and details
  So I can identify items I am interested in purchasing

  Background:
    # Given an initial setup
    Given a logged in customer
  
  # READ METHODS
  Scenario: View item list page
    When I go to the items page
    Then I should see "Featured Items at GPBO"
    And I should see "Name"
    And I should see "Price"
    And I should see "GPBO Muffin Tray"
    And I should see "$5.50"
    And I should see "Other Items at GPBO"
    And I should see "Home Hero Spatula Set"
    And I should see "$8.95"
    And I should see "Find by Category"
    And I should see "All"
    And I should see "Ingredients"
    And I should see "Pans"
    And I should see "GPBO Whisk"
    And I should not see "A stainless steel whisk for hand-beating eggs and other baking items."
    And I should not see "Silver"
    And I should not see "GPBO Mini Muffin Tray"
    And I should not see "Inactive"
    And I should not see "Inventory"
    And I should not see "Add a New Item"

  Scenario: View item list page for a given category
    When I go to the items page
    And I click on the link "Ingredients" 
    Then I should see "There are no featured items in that category at this time."
    And I should see "King Arthur All-Purpose Flour"
    And I should see "$3.95"
    And I should not see "GPBO Muffin Tray"
    And I should not see "$5.50"
    And I click on the link "Pans" 
    Then I should not see "King Arthur All-Purpose Flour"
    And I should not see "$3.95"
    And I should see "Featured Items at GPBO"
    And I should see "GPBO Muffin Tray"
    And I should see "$5.50"
    And I should see "Other Items at GPBO"
    And I should see "GPBO Baking Sheet"
    And I should see "$5.95"
    And I click on the link "All" 
    Then I should see "King Arthur All-Purpose Flour"
    And I should see "$3.95"
    And I should see "Featured Items at GPBO"
    And I should see "GPBO Muffin Tray"
    And I should see "$5.50"
    And I should see "Other Items at GPBO"
    And I should see "GPBO Baking Sheet"
    And I should see "GPBO Whisk"
    And I should not see "A stainless steel whisk for hand-beating eggs and other baking items."
    And I should see "Home Hero Spatula Set"

  Scenario: The item name is a link to details
    When I go to the items page
    And I click on the link "GPBO Whisk"
    Then I should see "A stainless steel whisk for hand-beating eggs and other baking items."
    And I should see "Color: Silver"
    And I should see "Weight: 0.45 lbs"
    And I should see "Current Price: $4.25"
    And I should see "Similar Items"
    And I should see "Home Hero Spatula Set"
    And I should not see "GPBO Muffin Tray"
    And I should see "Display All"
    And I should not see "Edit GPBO Whisk"
    And I should not see "Price History"
    And I should not see "Add a New Price"
    And I should not see "Inventory Level: 84"
    And I should not see "Reorder Level: 25"
    And I should not see "Make Inactive"



