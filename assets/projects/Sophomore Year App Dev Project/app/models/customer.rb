class Customer < ApplicationRecord
  # Modules to help with some functionality
  include AppHelpers::Validations
  include AppHelpers::Deletions
  include AppHelpers::Activeable::InstanceMethods
  extend AppHelpers::Activeable::ClassMethods

  attr_accessor :username, :password, :password_confirmation, :role, :greeting

  # Relationships
  belongs_to :user
  has_many :addresses
  has_many :orders
  has_many :order_items, through: :orders

  # Scopes
  scope :alphabetical,  -> { order(:last_name, :first_name) }
  scope :search,        ->(term) { where('first_name LIKE ? OR last_name LIKE ?', "%#{term}%", "#{term}%") }


  # Validations
  validates_presence_of :first_name, :last_name
  validates_format_of :phone, with: /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/, message: "should be 10 digits (area code needed) and delimited with dashes only"
  validates_format_of :email, with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, message: "is not a valid format"

  # Callbacks
  before_save    -> { strip_nondigits_from(:phone) }
  before_update :deactive_user_if_customer_inactive
  before_destroy :cannot_destroy_object

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

  private  
  def deactive_user_if_customer_inactive
    if !self.active && !self.user.nil?
      self.user.active = false
      self.user.save
    end
  end

end
