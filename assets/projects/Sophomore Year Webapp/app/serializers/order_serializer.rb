class OrderSerializer
    # OrderSerializer draws from Address and OrderCustomer serializers
    include FastJsonapi::ObjectSerializer

    attributes :date, :products_total, :tax, :shipping

    attribute :customer do |object|
        OrderCustomerSerializer.new(object.customer)
    end
    
    attribute :address do |object|
        AddressSerializer.new(object.address)
    end
end