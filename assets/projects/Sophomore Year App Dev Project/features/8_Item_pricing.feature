Feature: Add New Prices
  As an administrator
  I want to be able to adjust item prices
  So I can adjust to changing market demands

  Background:
    # Given an initial setup
    Given a logged in admin
  
  Scenario: Adding new price to item
    When I go to the Baking Sheet details
    And I click on the link "Add a New Price"
    Then I should see "New price for GPBO Baking Sheet"
    And I should see "Current price: $5.95"
    And I should see "Enter new price"
    And I fill in "item_price_price" with "6.25"
    And I press "Create Item price"
    And I should see "Successfully updated the price."
    And I should see "GPBO Baking Sheet"
    And I should see "Price History"
    And I should see "$6.25"
    And I should see "$5.95"
    And I should see "$5.25"
    And I should see "Add a New Price"
    And I should see "Inventory Level: 100"
    And I should see "Reorder Level: 50"
