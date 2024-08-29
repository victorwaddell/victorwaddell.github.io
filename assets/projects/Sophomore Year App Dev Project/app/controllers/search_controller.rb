class SearchController < ApplicationController
    def search
        if logged_in?
            if current_user.role?(:customer)
                redirect_back(fallback_location: home_path) if params[:query].blank?
                @query = params[:query]
                @items = Item.search(@query)
                @total_hits = @items.size
            end
        end
        if logged_in?
            if current_user.role?(:admin)
                redirect_back(fallback_location: home_path) if params[:query].blank?
                @query = params[:query]
                @customers = Customer.search(@query)
                @items = Item.search(@query)
                @total_hits = @items.size + @customers.size
            end
        end
    end


end
