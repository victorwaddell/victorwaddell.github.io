class CustomersController < ApplicationController
    before_action :set_customer, only: [:show, :edit, :update]
    before_action :check_login, except: [:new, :create]
    authorize_resource

    def index
        # finding all the active customers and paginating that list (will_paginate)
        @active_customers = Customer.active.alphabetical.paginate(page: params[:page]).per_page(15)
        @inactive_customers = Customer.inactive.alphabetical.paginate(page: params[:page]).per_page(15)
    end
    
    def show
        authorize! :show, @customer
        @previous_orders = @customer.orders.chronological.paid
        @addresses = @customer.addresses.by_recipient.all
    end
    
    def new
        @customer = Customer.new
    end
    
    def edit
    end

    def create
        @customer = Customer.new(customer_params)
        @user = User.new(user_params)
        unless logged_in? && current_user.role == "admin"
          @user.role = "customer"
        end
        if !@user.save
          @customer.valid?
          render action: 'new'
        else
          @customer.user_id = @user.id
          if @customer.save
            session[:user_id] = @user.id
            flash[:notice] = "#{@customer.proper_name} was added to the system."
            redirect_to customer_path(@customer) 
          else
            render action: 'new'
          end
        end   
      end
    
    def update
        respond_to do |format|
          if @customer.update_attributes(customer_params)
            format.html { redirect_to(@customer, :notice => "#{@customer.proper_name} was added to the system.") }
            format.json { respond_with_bip(@customer) }
          else
            format.html { render :action => "edit" }
            format.json { respond_with_bip(@customer) }
          end
        end
    end

    private
    def set_customer
      @customer = Customer.find(params[:id])
    end

    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :email, :phone, :active, :user)
    end

    def user_params      
      params.require(:customer).permit(:username, :greeting, :role, :active, :password, :password_confirmation)
    end

end
