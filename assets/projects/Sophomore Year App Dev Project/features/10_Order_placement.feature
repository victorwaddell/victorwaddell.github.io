Feature: Order placement
	As as a customer
  I want to be able to add items to a cart and checkout
  So I can order items from GPBO

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
    Then I should see "GPBO Muffin Tray"
    And I should see "Unit Price: $5.50"
    And I should see "Quantity: 1"
    And I should see "Subtotal: $5.50"
    When I click on the link "Continue shopping"
    And I click on the link "GPBO Whisk"
    And I click on the link "Add to Cart"
    Then I should see "GPBO Whisk was added to cart."
    And I should see "View Cart(2)"
    # add a second whisk to cart to increase quantity
    When I click on the link "Add to Cart"  
    When I click on the link "View Cart(2)"
    Then I should see "Your Cart"
    Then I should see "GPBO Muffin Tray"
    And I should see "Unit Price: $5.50"
    And I should see "Quantity: 1"
    And I should see "Subtotal: $5.50"
    And I should see "GPBO Whisk"
    And I should see "Unit Price: $4.25"
    And I should see "Quantity: 2"
    And I should see "Subtotal: $8.50"
    And I should see "Shipping:"
    And I should see "$5.00"
    And I should see "Grand Total:"
    And I should see "$19.00"

  Scenario: remove item from the cart
    When I go to the items page
    And I click on the link "GPBO Muffin Tray"
    Then I should see "View Cart"
    And I should see "Current Price: $5.50"
    When I click on the link "Add to Cart"
    Then I should see "GPBO Muffin Tray was added to cart."
    And I should see "View Cart(1)"
    When I click on the link "View Cart(1)"
    Then I should see "Your Cart"
    Then I should see "GPBO Muffin Tray"
    When I click on the link "Remove"
    Then I should see "GPBO Muffin Tray was removed from cart."
    And I should see "Your cart is currently empty."
    And I should see "Start shopping"
    And I should not see "Continue shopping"
    When I click on the link "Start shopping"
    Then I should see "Featured Items at GPBO"


  Scenario: Empty the cart
    When I go to the items page
    And I click on the link "GPBO Muffin Tray"
    Then I should see "View Cart"
    And I should see "Current Price: $5.50"
    When I click on the link "Add to Cart"
    Then I should see "GPBO Muffin Tray was added to cart."
    And I should see "View Cart(1)"
    When I click on the link "View Cart(1)"
    Then I should see "Your Cart"
    Then I should see "GPBO Muffin Tray"
    And I should see "Unit Price: $5.50"
    And I should see "Quantity: 1"
    And I should see "Subtotal: $5.50"
    When I click on the link "Continue shopping"
    And I click on the link "GPBO Whisk"
    And I click on the link "Add to Cart"
    Then I should see "GPBO Whisk was added to cart."
    And I should see "View Cart(2)"
    When I click on the link "View Cart(2)"
    Then I should see "Your Cart"
    And I should see "GPBO Muffin Tray"
    And I should see "GPBO Whisk"
    And I should see "Subtotal:"
    And I should see "$9.75"
    And I should see "Shipping:"
    And I should see "$5.00"
    And I should see "Grand Total:"
    And I should see "$14.75"
    When I click on the link "Empty cart" 
    Then I should see "Cart is emptied."
    And I should see "Your cart is currently empty."
    And I should see "Start shopping"

  Scenario: Checkout
    When I go to the items page
    And I click on the link "GPBO Muffin Tray"
    Then I should see "View Cart"
    And I should see "Current Price: $5.50"
    When I click on the link "Add to Cart"
    Then I should see "GPBO Muffin Tray was added to cart."
    And I should see "View Cart(1)"
    When I click on the link "View Cart(1)"
    Then I should see "Your Cart"
    Then I should see "GPBO Muffin Tray"
    And I should see "Unit Price: $5.50"
    And I should see "Quantity: 1"
    And I should see "Subtotal: $5.50"
    When I click on the link "Continue shopping"
    And I click on the link "GPBO Whisk"
    And I click on the link "Add to Cart"
    Then I should see "GPBO Whisk was added to cart."
    And I should see "View Cart(2)"
    When I click on the link "View Cart(2)"
    Then I should see "Your Cart"
    And I should see "GPBO Muffin Tray"
    And I should see "GPBO Whisk"
    And I should see "Subtotal:"
    And I should see "$9.75"
    And I should see "Shipping:"
    And I should see "$5.00"
    And I should see "Grand Total:"
    And I should see "$14.75"
    When I click on the link "Checkout" 
    # Then show me the page
    And I select "Alex Egan - 5000 Forbes Avenue Pittsburgh, PA 15213" from "order_address_id"
    And I fill in "order_credit_card_number" with "4444111122225555"
    And I select "9" from "order_expiration_month"
    And I select "2022" from "order_expiration_year"
    And I press "Place order"
    Then I should see "Thank you for ordering from GPBO."
    And I should see "Order Details"
    And I should see "2 Items"
    And I should see "Recipient: Alex Egan"