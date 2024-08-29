class CustomerItemSerializer
    # For CustomerOrderSerializer
    # Is actually an order_item
    include FastJsonapi::ObjectSerializer
    set_type :item
    
    attribute :name do |object|
        object.item.name
    end 

    attribute :quantity 

    attribute :shipped? do |object|
        #object.shipped # should be a scope from orderitems for this shipped? attribute
        object.shipped_on ? true : false
    end

end