class CustomerItemSerializer
  include FastJsonapi::ObjectSerializer
  set_type :item

  attribute :name do |object|
    object.item.name
  end

  attribute :quantity do |object|
    object.quantity
  end

  attribute :shipped? do |object|
    object.shipped_on ? true : false
  end
end