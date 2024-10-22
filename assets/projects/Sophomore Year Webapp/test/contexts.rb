# Require needed files
require './test/sets/users'
require './test/sets/customers'
require './test/sets/addresses'
require './test/sets/categories'
require './test/sets/items'
require './test/sets/item_prices'
require './test/sets/orders'
require './test/sets/order_items'
require './test/sets/credit_cards'
require './test/sets/abilities'

module Contexts
  # explicitly include all sets of contexts used for testing 
  include Contexts::Users
  include Contexts::Customers
  include Contexts::Addresses
  include Contexts::Categories
  include Contexts::Items
  include Contexts::ItemPrices
  include Contexts::Orders
  include Contexts::OrderItems
  include Contexts::CreditCards
  include Contexts::Abilities

  def create_all
    create_customer_users
    puts "Built customer users"
    create_employee_users
    puts "Built employee users"
    create_customers
    puts "Built customers"
    create_addresses
    puts "Built addresses for customers"
    create_categories
    puts "Built categories"
    create_items
    puts "Built items -- all types"
    create_item_prices_retail
    puts "Built prices for active items"
    create_orders
    puts "Built orders"
    create_order_items
    puts "Built order items"
    
  end
end

