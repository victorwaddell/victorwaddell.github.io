class CustomerSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :last_name, :email
  attribute :phone do |object|
    ActionController::Base.helpers.number_to_phone(object.phone)
  end 

  attribute :number_of_orders do |object|
    object.orders.count
  end

  attribute :orders_by_date do |object|
    object.orders.chronological.map do |order|
      CustomerOrderSerializer.new(order).serializable_hash
    end
  end

end
