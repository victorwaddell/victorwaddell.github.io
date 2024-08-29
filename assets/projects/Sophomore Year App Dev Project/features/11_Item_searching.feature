# Feature: Searching GPBO
#   As as either an admin, customer, or guest
#   I want to be able to search GPBO
#   So I can find customers and/or items

#   Scenario: Searching as customer
#     Given a logged in customer
#     When I go to the home page
#     And I fill in "query" with "baking"
#     # And I press enter
#     Then I should see "Search result for term 'baking' resulted in 2 hits"
#     And I should see "GPBO Baking Sheet"
#     And I should see "GPBO Whisk"
#     And when I click on the link "GPBO Whisk"
#     Then I should see "A stainless steel whisk for hand-beating eggs and other baking items."
#     When I go to the home page
#     And I fill in "query" with "Alex\n"
#     Then I should see "Search result for term 'Alex' resulted in 0 hits"

#   Scenario: Searching as guest
#     Given an initial setup
#     When I go to the home page
#     And I fill in "query" with "baking"
#     # And I press enter
#     Then I should see "Search result for term 'baking' resulted in 2 hits"
#     And I should see "GPBO Baking Sheet"
#     And I should see "GPBO Whisk"
#     And when I click on the link "GPBO Whisk"
#     Then I should see "A stainless steel whisk for hand-beating eggs and other baking items."
#     When I go to the home page
#     And I fill in "query" with "Alex\n"
#     Then I should see "Search result for term 'Alex' resulted in 0 hits"

#   Scenario: Searching as admin
#     Given a logged in customer
#     When I go to the home page
#     And I fill in "query" with "baking\n"
#     # And I press enter
#     Then I should see "Search result for term 'baking' resulted in 2 hits"
#     And I should see "GPBO Baking Sheet"
#     And I should see "GPBO Whisk"
#     And when I click on the link "GPBO Whisk"
#     Then I should see "A stainless steel whisk for hand-beating eggs and other baking items."
#     When I go to the home page
#     And I fill in "query" with "Alex\n"
#     Then I should see "Search result for term 'Alex' resulted in 1 hit"