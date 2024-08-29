class AddressSerializer
    include FastJsonapi::ObjectSerializer
    attributes :recipient, :street_1, :street_2, :city, :state, :zip
end