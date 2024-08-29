class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update]
    before_action :check_login
    authorize_resource

    def index
        # finding all the active employees and paginating that list (will_paginate)
        @employees = User.employees.all.paginate(page: params[:page]).per_page(15)
    end
    
    def new
        @user = User.new
    end
    
    def edit
        @user.role = "customer" if current_user.role?(:customer)
    end

    def create
        @user = User.new(user_params)
        @user.role = "customer" if current_user.role?(:customer)
        if @user.save
          flash[:notice] = "Successfully added #{@user.username} as a user."
          redirect_to users_url
        else
          render action: 'new'
        end
      end
    
    def update
        if @user.update_attributes(user_params)
          flash[:notice] = "Successfully updated #{@user.username}."
          redirect_to users_url
        else
          render action: 'edit'
        end
    end

    private
    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:username, :password, :password_confirmation, :role, :active)
    end

end