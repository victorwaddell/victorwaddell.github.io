module Api::V1
  class OrdersController < ApiController
    def index 
      @orders = Order.chronological.all
      render json: OrderSerializer.new(@orders).serialized_json
    end
  end
end