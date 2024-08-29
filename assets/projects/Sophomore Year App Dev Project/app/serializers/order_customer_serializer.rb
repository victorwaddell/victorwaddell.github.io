class OrderCustomerSerializer
  include FastJsonapi::ObjectSerializer
  set_type :customer
  attributes :name, :email
  attribute :phone do |object|
    ActionController::Base.helpers.number_to_phone(object.phone)
  end 

end