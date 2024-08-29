Feature: View Items for Administrator
  As an administrator
  I want to be able to view item lists and details
  So I can manage item pricing and inventory

  Background:
    # Given an initial setup
    Given a logged in admin
  
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
    And I should see "Inventory"
    And I should see "190"
    And I should see "Add a New Item"

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
    And I should not see "GPBO Muffin Tray"
    And I should not see "GPBO Baking Sheet"
    And I should see "Display All"
    And I should see "Edit GPBO Whisk"
    And I should see "Price History"
    And I should see "Date"
    And I should see "Price"
    And I should see "Add a New Price"
    And I should see "Inventory Level: 84"
    And I should see "Reorder Level: 25"
    And I should see "Make Inactive"

  Scenario: The admin can see and toggle an item between active and inactive states
    When I go to the items page
    And I click on the link "GPBO Whisk"
    And I click on the link "Make Inactive"
    Then I should see "GPBO Whisk was made inactive"
    And I should see "Make Active"
    And I click on the link "Make Active"
    Then I should see "GPBO Whisk was made active"

  Scenario: The admin can see and toggle an item to make it featured or not
    When I go to the items page
    And I click on the link "GPBO Baking Sheet"
    And I click on the link "Make Featured"
    Then I should see "GPBO Baking Sheet is now featured"
    And I should see "Stop Featured"
    And I click on the link "Stop Featured"
    Then I should see "GPBO Baking Sheet is no longer featured"



