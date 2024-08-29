class OrderAddressSerializer
  include FastJsonapi::ObjectSerializer
  set_type :address
  attributes :recipient, :street_1, :street_2, :city, :state, :zip
end