Feature: Customer Sign-Up
	As a guest
	I want to create a customer account on the system
	In order to place orders

  Scenario: Sign-up successful
    Given an initial setup
    When I go to the home page
    And I click on the link "Become a Customer"
    Then I should not see "Role"
    When I fill in "customer_first_name" with "Ed"
    And I fill in "customer_last_name" with "Gruberman"
    And I fill in "customer_phone" with "412-268-2323"
    And I fill in "customer_email" with "gruberman@example.com"
    And I fill in "customer_username" with "egruberman"
    And I fill in "customer_password" with "secret"
    And I fill in "customer_password_confirmation" with "secret"
    And I fill in "customer_greeting" with "Ed!"
    And I press "Create Customer"
    Then I should see "Ed Gruberman"
    And I should see "Active: Yes"
    And I should see "A GPBO customer since 2022" 