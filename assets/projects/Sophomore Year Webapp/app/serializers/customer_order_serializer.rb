class CustomerOrderSerializer
    # For CustomerSerializer
    include FastJsonapi::ObjectSerializer
    set_type :order
    attributes :date

    attribute :total_weight do |object|
        object.total_weight
    end 

    attribute :grand_total do |object|
        ActionController::Base.helpers.number_to_currency(object.grand_total)
    end 

    attribute :items do |object| #sort orders by date DESC?
        object.order_items.alphabetical.map do |order_item|
            CustomerItemSerializer.new(order_item).serializable_hash
        end
    end
end