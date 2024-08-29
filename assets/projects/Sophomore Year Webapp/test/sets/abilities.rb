module Contexts
  module Abilities
    # Admins
    def create_admin_abilities
      @mark_user = FactoryBot.create(:user, username: "mark", role: "admin")
      @mark_ability = Ability.new(@mark_user)
    end

    def delete_admin_abilities
      @mark_user.delete
    end

    # Customers
    def create_customer_abilities
      # created related objects for testing
      create_categories
      create_items
      create_item_prices_retail
      create_customer_users
      create_customers
      create_addresses
      create_orders
      create_order_items
      # make the melanie ability using the melanie user
      @melanie_ability = Ability.new(@u_melanie)
    end

    # Shippers
    def create_shipper_abilities
      @shipper_user = FactoryBot.create(:user, username: "shipper", role: "shipper")
      @shipper_ability = Ability.new(@shipper_user)
      # created related objects for testing
      create_categories
      create_items
      create_item_prices_retail
      create_customer_users
      create_customers
      create_addresses
      create_orders
      create_order_items
    end

    # Guests
    def create_guest_abilities
      @guest_user = User.new
      @guest_ability = Ability.new(@guest_user)
    end

  end
end