class CustomersController < ApplicationController
    # Swagger Doc
    swagger_controller :customers, "Customers Management"

    swagger_api :show do
        summary "Shows one Customer"
        param :path, :id, :integer, :required, "Customer ID"
        notes "This lists details of one Customer"
        response :not_found
    end

    # Controller Code
    # Since API is readonly, do :show as only action
    before_action :set_customer, only: [:show]
  
    # GET /customer/1
    def show
        render json: CustomerSerializer.new(@customer)
    end

    private
      # Use callbacks to share common setup or constraints between actions.
    def set_customer
        @customer = Customer.find(params[:id])
    end
    # Only allow a trusted parameter "white list" through.
    def customer_params
        params.permit(:user, :first_name, :last_name, :phone, :email, :active)
    end
    
end