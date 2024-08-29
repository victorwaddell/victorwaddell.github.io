class OrdersController < ApplicationController
    # Swagger Doc
    swagger_controller :orders, "Orders Management"

    swagger_api :index do
      summary "Fetches all Orders"
      notes "This lists all the Orders"
    end

    # Controller Code
    # Since API is readonly, do :show as only action
    before_action :set_order, only: [:show]
  
    # GET /orders
    def index
        @orders = Order.chronological.all

        render json: OrderSerializer.new(@orders)
    end

    private
      # Use callbacks to share common setup or constraints between actions.
    def set_order
        @order = Order.find(params[:id])
    end
    # Only allow a trusted parameter "white list" through.
    def order_params
        params.permit(:customer, :address, :date, :products_total, :tax, :shipping, :credit_card_number, :expiration_year, :expiration_month, :payment_receipt)
    end
end