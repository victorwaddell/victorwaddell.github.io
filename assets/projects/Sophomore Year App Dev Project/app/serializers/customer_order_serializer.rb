class CustomerOrderSerializer
  include FastJsonapi::ObjectSerializer
  set_type :order

  attributes :date, :total_weight
  
  attribute :grand_total do |object|
    ActionController::Base.helpers.number_to_currency(object.grand_total)
  end 
  
  attribute :items do |object|
    object.order_items.alphabetical.map do |order_item|
      CustomerItemSerializer.new(order_item).serializable_hash
    end
  end
end