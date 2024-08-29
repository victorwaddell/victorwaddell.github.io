class OrderSerializer
  include FastJsonapi::ObjectSerializer
  attributes :date, :products_total, :shipping

  attribute :customer do |object|
    OrderCustomerSerializer.new(object.customer).serializable_hash
  end

  attribute :address do |object|
    OrderAddressSerializer.new(object.address).serializable_hash
  end
end
