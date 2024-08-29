class ItemsController < ApplicationController
    before_action :set_item, only: [:show, :edit, :update, :destroy, :toggle_active, :toggle_feature]
    before_action :check_login, except: [:index, :show]
    authorize_resource

    def index
        if params[:category].present?
            @category = Category.find(params[:category])
            @categories = Category.all.paginate(page: params[:page]).per_page(15)
            @featured_items = @category.items.featured.paginate(page: params[:page]).per_page(15)
            @other_items = @category.items.active.paginate(page: params[:page]).per_page(15) - @featured_items
        else
            @categories = Category.all.paginate(page: params[:page]).per_page(15)
            @featured_items = Item.featured.all.paginate(page: params[:page]).per_page(15)
            @other_items = Item.active.all.paginate(page: params[:page]).per_page(15) - @featured_items
        end
    end

    def show
        if logged_in?
            if current_user.role?(:admin)
                @prices = @item.item_prices.chronological.all
            end
        end
        @category = @item.category
        @similar_items = @category.items.active.all
    end

    def new
        @item = Item.new
    end

    def edit
    end

    def create
        @item = Item.new(item_params)
        if @item.save
            flash[:notice] = "#{@item.name} was added to the system."
            redirect_to item_path(@item)
        else
            render action: 'new'
        end
    end

    def update
        if @item.update_attributes(item_params)
            flash[:notice] = "Successfully updated #{@item.name}."
            redirect_to item_path(@item)
        else
            render action: 'edit'
        end
    end

    def toggle_active
        # Also am not sure how to do other items in Index
        if @item.active?
            @item.make_inactive
            flash[:notice] = "#{@item.name} was made inactive"
        else
            @item.make_active
            flash[:notice] = "#{@item.name} was made active"
        end
        redirect_back fallback_location: home_path
        #redirect_to home_path, notice: "#{@item.name} is now featured."
    end  

    def toggle_feature
        if @item.is_featured
            @item.update_attributes(is_featured: false)
            flash[:notice] = "#{@item.name} is no longer featured"
        else
            @item.update_attributes(is_featured: true)
            flash[:notice] = "#{@item.name} is now featured"
        end
        redirect_back fallback_location: home_path
        #redirect_to home_path, notice: "#{@item.name} is now featured."
    end

    def destroy
        if @item.destroy
            flash[:notice] = "Successfully removed #{@item.name}."
            redirect_to items_path
        else
            redirect_to item_path(@item) # redirect to particular item
        end
    end

    private
    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:category_id, :name, :description, :color, :weight, :inventory_level, :reorder_level, :is_featured, :active)
    end


end
