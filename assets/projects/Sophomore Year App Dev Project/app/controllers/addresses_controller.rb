class AddressesController < ApplicationController
    before_action :set_address, only: [:show, :update]
    before_action :check_login
    authorize_resource

    def index
        # get all address in alphabetical order, 10 per page 
        @active_addresses = current_user.customer.addresses.active
        @inactive_addresses = current_user.customer.addresses.inactive
    end

    def show
    end

    def new
        @address = Address.new
    end

    def create
        @address = Address.new(address_params)
        if @address.save
          flash[:notice] = "The address was added to #{@address.customer.proper_name}."
          redirect_to @address.customer
        else
          render action: 'new'
        end
    end

    def edit
    end

    def update
        if @address.update_attributes(address_params)
          flash[:notice] = "Successfully updated address #{@address.street_1}."
          redirect_to addresses_path
        else
          render action: 'edit'
        end
    end

    private
    def set_address
      @address = Address.find(params[:id])
    end

    def address_params
      params.require(:address).permit(:customer_id, :is_billing, :recipient, :street_1, :city, :state, :zip, :active)
    end
end
