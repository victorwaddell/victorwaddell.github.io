module Api::V1
  class CustomersController < ApiController
    def show 
      @customer = Customer.find(params[:id])
      render json: CustomerSerializer.new(@customer).serialized_json
    end
  end
end