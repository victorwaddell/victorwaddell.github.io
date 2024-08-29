Feature: Add New Items
  As an administrator
  I want to be able to add and edit items
  So I can adjust manage my inventory

  Background:
    # Given an initial setup
    Given a logged in admin
  
  Scenario: Adding new item
    When I go to the new item page
    And I fill in "item_name" with "GPBO Cake Ring"
    And I select "Pans" from "item_category_id"
    And I fill in "item_description" with "The best cake ring ever!"
    And I fill in "item_weight" with "0.85"
    And I fill in "item_color" with "Black"
    And I fill in "item_inventory_level" with "154"
    And I fill in "item_reorder_level" with "37"
    And I press "Create Item"
    And I should see "GPBO Cake Ring was added to the system."
    And I should see "GPBO Cake Ring"
    And I should see "Inventory Level: 154"
    And I should see "Reorder Level: 37"
    And I should not see "Price History"
    And I should not see "$"
    And I should see "Add a New Price"

  Scenario: Editing an item
    When I go to edit Baking Sheet
    And I fill in "item_inventory_level" with "154"
    And I press "Update Item"
    And I should see "Inventory Level: 154"
