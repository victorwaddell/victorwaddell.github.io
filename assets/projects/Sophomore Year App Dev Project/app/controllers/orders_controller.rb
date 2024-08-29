class OrdersController < ApplicationController
    include AppHelpers::Cart
    include AppHelpers::Shipping
    include ApplicationHelper
    before_action :check_login, only: [:show]
    authorize_resource
    
    def index
        if logged_in?    
            if current_user.role?(:admin)
                # login_admin
                @pending_orders = Order.chronological.not_shipped.all # assert_not_nil assigns(:pending_orders)
                @past_orders = Order.chronological.all - @pending_orders # assert_not_nil assigns(:past_orders)
                @all_orders = Order.chronological.all
            end
        end

        if logged_in?
            if current_user.role?(:customer)
                # login_customer
                @all_orders = current_user.customer.orders.chronological.all # assert_not_nil assigns(:all_orders)
            end
        end
    end

    def show
        @order = Order.find(params[:id])
        @previous_orders = @order.customer.orders.all  # assert_not_nil assigns(:previous_orders)
        @order_items = @order.order_items              # assert_not_nil assigns(:order_items)
    end

    def create
        if logged_in?
            if current_user.role?(:customer)
                order_helper()
                if @order.save
                    save_each_item_in_cart(@order)
                    @order.pay
                    clear_cart
                    flash[:notice] = "Thank you for ordering from GPBO."
                    redirect_to order_path(Order.last)
                else
                    redirect_to checkout_path()
                end
            end
        end
    end

    private
    def order_params
      params.require(:order).permit(:customer_id, :address_id, :credit_card_number, :expiration_year, :expiration_month)
    end

    def order_helper
        @order = Order.new(order_params)
        @order.date = Date.today
        @order.shipping = calculate_cart_shipping()
        @order.products_total = calculate_cart_items_cost()
    end

end