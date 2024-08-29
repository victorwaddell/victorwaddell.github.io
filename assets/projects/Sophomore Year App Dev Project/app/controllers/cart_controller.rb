class CartController < ApplicationController
    include AppHelpers::Cart
    include AppHelpers::Shipping
    include ApplicationHelper

    before_action :check_login

    def show
        get_related_data()
    end

    def add_item
        @item = Item.find(params[:id])
        add_item_to_cart(params[:id])
        flash[:notice] = "#{@item.name} was added to cart."
        redirect_to item_path(@item)
    end

    def remove_item
        @item = Item.find(params[:id])
        remove_item_from_cart(params[:id])
        flash[:notice] = "#{@item.name} was removed from cart."
        redirect_to view_cart_path(@cart)
    end

    def empty_cart
        clear_cart
        flash[:notice] = "Cart is emptied."
        redirect_back fallback_location: home_path
    end

    def checkout
        get_related_data()
        @addresses = get_address_options_long(current_user) # Application Helper
        @order = Order.new
    end

    private
    def get_related_data()
        @items_in_cart = get_list_of_items_in_cart() # Cart Helper
        @subtotal = calculate_cart_items_cost()      # Cart Helper
        @shipping_cost = calculate_cart_shipping()   # Shipping helper
        @total = @subtotal + @shipping_cost
    end


end
