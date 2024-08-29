class Order < ApplicationRecord
  # Modules to help with some functionality
  include AppHelpers::Validations
  require 'base64'
  
  # Relationships
  belongs_to :customer
  belongs_to :address
  has_many :order_items
  has_many :items, through: :order_items

  # Virtual attributes for credit cards (non-saved)
  attr_accessor :credit_card_number
  attr_accessor :expiration_year
  attr_accessor :expiration_month

  # Scopes
  scope :chronological, -> { order(date: :desc) }
  scope :paid,          -> { where.not(payment_receipt: nil) }
  scope :for_customer,  ->(customer_id) { where(customer_id: customer_id) }

  # Validations
  validates_numericality_of :products_total, greater_than_or_equal_to: 0
  validates_numericality_of :shipping, greater_than_or_equal_to: 0

  validates_date :date
  validate -> { is_active_in_system(:customer) }, on: :create
  validate -> { is_active_in_system(:address) }, on: :create
  validate :credit_card_number_is_valid
  validate :expiration_date_is_valid

  # Other methods
  def grand_total
    (products_total + shipping).round(2)
  end

  def pay
    return false unless self.payment_receipt.nil?
    generate_payment_receipt
    self.save!
    self.payment_receipt
  end

  def credit_card_type
    credit_card.type.nil? ? "N/A" : credit_card.type.name
  end

  def total_weight
    weight = self.order_items.inject(0){|sum, oi| sum += oi.item.weight * oi.quantity}
  end

  def self.not_shipped
    # joins(:order_items).where("order_items.shipped_on IS NULL").to_a.uniq
    joins(:order_items).where("order_items.shipped_on IS NULL").distinct
  end

  # Callbacks
  # before_destroy do
  #   check_if_any_order_item_has_been_shipped
  #   if errors.present?
  #     @destroyable = false
  #     throw(:abort)
  #   end
  # end

  private
  def generate_payment_receipt
    self.payment_receipt = Base64.encode64("order: #{self.id}; amount_paid: #{self.grand_total}; received: #{self.date}")
  end

  def credit_card
    CreditCard.new(self.credit_card_number, self.expiration_year, self.expiration_month)
  end

  def credit_card_number_is_valid
    return false if self.expiration_year.nil? || self.expiration_month.nil?
    if self.credit_card_number.nil? || credit_card.type.nil?
      errors.add(:credit_card_number, "is not valid")
    end
  end

  def expiration_date_is_valid
    return false if self.credit_card_number.nil? 
    if self.expiration_year.nil? || self.expiration_month.nil? || credit_card.expired?
      errors.add(:expiration_year, "is expired")
    end
  end

  # def check_if_any_order_item_has_been_shipped
  #   unless self.order_items.shipped.empty?
  #     errors.add(:base, "Items from this order have already been shipped; the order cannot be deleted.")
  #   end
  # end

end
