class Ability
  include CanCan::Ability
  
  def initialize(user)
    # set user to new User if not logged in
    user ||= User.new # i.e., a guest user
    
    # set authorizations for different user roles
    ## ADMIN
    if user.role? :admin
      # they get to do it all
      can :manage, :all


    ## SHIPPER
    elsif user.role? :shipper
      can :index, Item
      can :show, Item
      can :index, Order
      can :show, Order
      can :show, Address

      
    ## CUSTOMER
    elsif user.role? :customer
      can :index, Item
      can :show, Item
      
      # they can read and update their own profile
      # can :show, Customer, user_id: user.id  # new, more compact method
      can :show, Customer do |c|  
        c.id == user.customer.id
      end
      can :show, User do |u|  
        u.id == user.id
      end

      can :update, Customer do |c|  
        c.id == user.customer.id
      end
      can :update, User do |u|  
        u.id == user.id
      end
      
      # they can see an order if it belongs to them
      # can :show, Order, customer_id: user.customer.id
      can :show, Order do |this_order|
        my_orders = user.customer.orders.map(&:id) 
        my_orders.include? this_order.id
      end

      can :index, Order  # controller to filter orders to just customer
      can :create, Order  # whole point is to let customers order...
      can :add_to_cart, Order
      can :checkout, Order

      can :create, Address  # can add addresses to the system

      # they can see and edit an address if it belongs to them
      can :show, Address do |this_address|
        my_addresses = user.customer.addresses.map(&:id) 
        my_addresses.include? this_address.id
      end

      can :update, Address do |this_address|
        my_addresses = user.customer.addresses.map(&:id) 
        my_addresses.include? this_address.id
      end   

      can :index, Address  # controller to filter addresses appropriately

    else
      can :index, Item
      can :show, Item
      can :create, Customer
    end
  end
end