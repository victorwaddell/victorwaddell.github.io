# require needed files
require 'helpers/validations'
require 'helpers/deletions'
require 'helpers/activeable'
require 'helpers/cart'
require 'helpers/shipping'

# create AppHelpers
module AppHelpers
  include AppHelpers::Validations
  include AppHelpers::Deletions
  include AppHelpers::Activeable::ClassMethods
  include AppHelpers::Activeable::InstanceMethods
  include AppHelpers::Cart
  include AppHelpers::Shipping
end