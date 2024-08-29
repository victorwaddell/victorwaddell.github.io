Feature: Authentication
	As an administrator
	I want to create and access an account on the system
	In order to manage the system as an authenticated user

  Scenario: Login successful
    Given an initial setup
    When I go to the login page
    And I fill in "username" with "mark"
    And I fill in "password" with "secret"
    And I press "Log In"
    Then I should see "Logged in!"
		
  Scenario: Login failed
    Given an initial setup
    When I go to the login page
    And I fill in "username" with "mark"
    And I fill in "password" with "notsecret"
    And I press "Log In"
    Then I should see "Username and/or password is invalid"
		
  Scenario: Logout
    Given a logged in customer
    When I go to the home page
    And I click on the link "Logout"
    Then I should see "Logged out!"
	
	Scenario: Admin navigation exists to link resources
		Given a logged in admin
	  When I go to the home page
		And I click on the link "Items"
	  Then I should see "Featured Items at GPBO"
	  When I go to the home page
		And I click on the link "Customers"
	  Then I should see "Active Customers in GPBO"
    When I go to the home page
		And I click on the link "Orders"
	  Then I should see "Pending Orders"
    And I should see "Past Orders"
    When I go to the home page
    And I click on the link "Employees"
	  Then I should see "Employees at GPBO"
    When I go to the home page
	  Then I should not see "Addresses"
    And I should not see "Prices"

  Scenario: Customer navigation exists to link resources
		Given a logged in customer
	  When I go to the home page
		And I click on the link "Items"
    Then I should see "Featured Items at GPBO"
	  When I go to the home page
		And I click on the link "My Account"
	  Then I should see "Alex Egan"
    When I go to the home page
		And I click on the link "View Cart"
	  Then I should see "Your Cart"
    When I go to the home page
		And I click on the link "My Orders"
	  Then I should not see "Pending Orders"
    And I should not see "Past Orders"
    When I go to the home page
    And I should not see "Prices"
    And I should not see "Employees"

  Scenario: Guest navigation exists to link resources
	  When I go to the home page
    Then I should see "Become a Customer"
    And I should see "Login"
		And I click on the link "Items"
    Then I should see "Featured Items at GPBO"
    And I should not see "Logout"
	  And I should not see "Customers"
    And I should not see "Prices"
    And I should not see "Employees"
