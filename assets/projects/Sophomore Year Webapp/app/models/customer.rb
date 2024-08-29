class Customer < ApplicationRecord
  # Modules to help with some functionality
  include AppHelpers::Deletions
  include AppHelpers::Validations
  include AppHelpers::Activeable::InstanceMethods
  extend AppHelpers::Activeable::ClassMethods

  # Relationships
  belongs_to :user
  has_many :addresses
  has_many :orders
  has_many :order_items, through: :orders

  # Scopes
  scope :alphabetical,  -> { order(:last_name, :first_name) }

  # Validations
  validates_presence_of :first_name, :last_name
  validates_format_of :phone, with: /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/, message: "should be 10 digits (area code needed) and delimited with dashes only"
  validates_format_of :email, with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, message: "is not a valid format"

  # Callbacks
  before_save    -> { strip_nondigits_from(:phone) } 
  before_destroy do 
    cannot_destroy_object()
  end
  # Callback to make customer inactive if user account is inactive
  before_update do
    if !self.active && self.user.active
      self.user.make_inactive
    end
  end

  # Other methods
  def name 
    "#{last_name}, #{first_name}"
  end

  def proper_name
    "#{first_name} #{last_name}"
  end

  def billing_address
    self.addresses.active.billing.first
  end

  
    

  

end
