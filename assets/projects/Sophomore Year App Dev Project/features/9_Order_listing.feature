Feature: Order listing
	As as either an admin or customer
  I want to be able to see information on orders
  So I can know the order history and process pending orders

  Scenario: Order listings for customer
    Given a logged in customer
    When I go to the orders page
    Then I should not see "Pending"
    And I should not see "Past"
    And I should see "All Orders"
    And I should see "Date"
    And I should see "Recipient"
    And I should see "Item Count"
    And I should see "Cost"
    And I should see "02/17/22"
    And I should see "Jeff Egan"
    And I should see "1"
    And I should see "$13.50"
    And I should not see "Melanie Freeman"
    And I should not see "Anthony Corletti"
    And I should not see "Ryan Flood"
    And I should not see "5000 Forbes"
    And I should not see "Round Cake Pan"

  Scenario: Order details for customer
    Given a logged in customer
    When I go to the orders page
    And I click on the link "02/17/22"
    And I should see "Order Details"
    And I should see "Date: February 17, 2022"
    And I should see "Recipient"
    And I should see "Recipient: Jeff Egan"
    And I should see "Order Cost Breakdown"
    And I should see "Product Subtotal"
    And I should see "Shipping"
    And I should see "Grand Total"
    And I should see "Previous Orders"
    And I should not see "02/17/22"
    And I should see "02/14/22"
    And I should see "Date"
    And I should see "Recipient"
    And I should see "Item Count"
    And I should see "Cost"
    And I should see "1 Item"
    And I should not see "1 Items"
    And I should see "GPBO Round Cake Pan"
    And I should see "Quantity"
    When I click on the link "GPBO Round Cake Pan"
    Then I should see "A set of 2 round cake pans, each with 8 inch diameter"

  Scenario: Order listings for admin
    Given a logged in admin
    When I go to the orders page
    Then I should see "Pending Orders"
    And I should see "Past Orders"
    And I should not see "All Orders"
    And I should see "Date"
    And I should see "Customer"
    And I should see "Recipient"
    And I should see "Item Count"
    And I should see "Cost"
    And I should see "02/17/22"
    And I should see "Egan, Alex"
    And I should see "Jeff Egan"
    And I should see "1"
    And I should see "$13.50"
    And I should see "Freeman, Melanie"
    And I should see "Anthony Corletti"
    And I should see "Ryan Flood"
    And I should not see "5000 Forbes"
    And I should not see "Round Cake Pan"
    When I click on the link "Ryan Flood"
    Then I should see "Address Information"
    And I should see "Recipient: Ryan Flood"
    And I should see "5000 Forbes Avenue"
    And I should see "Pittsburgh, PA 15213"

  Scenario: Order details for admin
    Given a logged in admin
    When I go to the orders page
    And I click on the link "02/11/22"
    And I should see "Order Details"
    And I should see "Date: February 11, 2022"
    And I should see "Recipient"
    And I should see "Customer: Alex Egan"
    And I should see "Recipient: Alex Egan"
    And I should see "Order Cost Breakdown"
    And I should see "Product Subtotal"
    And I should see "Shipping"
    And I should see "Grand Total"
    And I should see "Previous Orders"
    And I should not see "02/11/22"
    And I should see "02/14/22"
    And I should see "Date"
    And I should see "Recipient"
    And I should see "Item Count"
    And I should see "Cost"
    And I should see "2 Items"
    And I should not see "1 Items"
    And I should see "GPBO Whisk"
    And I should see "King Arthur All-Purpose Flour"
    And I should see "Quantity"