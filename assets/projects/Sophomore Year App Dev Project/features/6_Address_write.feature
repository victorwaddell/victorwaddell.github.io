Feature: Adding addresses
	As as a customer
  I want to be able to add new addresses when I order
  So I can send GPBO items to family and friends

  Background: 
    Given a logged in customer

  Scenario: Add items to the cart
    When I go to the items page
    And I click on the link "GPBO Muffin Tray"
    Then I should see "View Cart"
    And I should see "Current Price: $5.50"
    When I click on the link "Add to Cart"
    Then I should see "GPBO Muffin Tray was added to cart."
    And I should see "View Cart(1)"
    When I click on the link "View Cart(1)"
    Then I should see "Your Cart"
    When I click on the link "Checkout"
    And I click on the link "Add a new address"
    Then I should see "New Address"
    And I fill in "address_recipient" with "Ed Gruberman"
    And I fill in "address_street_1" with "250 East Ohio Street"
    And I fill in "address_street_2" with "Apt 221"
    And I fill in "address_city" with "Pittsburgh"
    And I select "Pennsylvania" from "address_state"
    And I fill in "address_zip" with "15212"
    And I press "Create Address"
    Then I should see "The address was added to Alex Egan."