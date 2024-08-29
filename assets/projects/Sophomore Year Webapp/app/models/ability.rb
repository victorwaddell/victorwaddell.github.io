class Ability
    include CanCan::Ability
    
    def initialize(user)
      # set user to new User if not logged in
      user ||= User.new # i.e., a guest user

    
        if user.role? :admin
            can :manage, :all


        elsif user.role? :shipper
            # can read items, orders, customers, and addresses
            can :read, Item
            can :read, Customer
            can :read, Address
            can :read, Order

            # # they can read their own profile
            # can :show, User do |u|  
            #     u.id == user.id
            # end

            # # they can update their own profile
            # can :update, User do |u|  
            #     u.id == user.id
            # end


        elsif user.role? :customer
            # they can see lists of items, their orders, and their addresses
            can :read, Item
            can :create, Order
            can :create, Address

            # orders
            can :read, Order do |this_order|  
                my_orders = user.customer.orders.map(&:id)
                my_orders.include? this_order.id 
            end

            can :add_to_cart, Order 
            can :checkout, Order

            # addresses
            can :read, Address do |this_address|  
                my_addresses = user.customer.addresses.map(&:id)
                my_addresses.include? this_address.id 
            end

            can :update, Address do |this_address|  
                my_addresses = user.customer.addresses.map(&:id)
                my_addresses.include? this_address.id 
            end

            # customer can view and update their profile
            # they can read their user profile
            can :show, User do |u|  
                u.id == user.id
            end

            # they can update their user profile
            can :update, User do |u|  
                u.id == user.id
            end

            # can read their own data
            can :show, Customer do |this_customer|  
                user.customer == this_customer
            end
            
            # can update their own data
            can :update, Customer do |this_customer|  
                user.customer == this_customer
            end
            

        else
            # guest can only read or create an account
            can :read, Item
            can :create, Customer
        end
    end
end