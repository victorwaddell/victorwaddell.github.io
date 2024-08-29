class OrderItem < ApplicationRecord
  include AppHelpers::Validations

  # Relationships
  belongs_to :item
  belongs_to :order

  # Validations
  validates_numericality_of :quantity, :only_integer => true, greater_than: 0
  validates_date :shipped_on, :allow_blank => true
  validate -> { is_active_in_system(:item) }, on: :create

  # Scope
  scope :shipped,  -> { where.not(shipped_on: nil) }
  scope :unshipped,  -> { where(shipped_on: nil) }
  scope :alphabetical,  -> { joins(:item).order(:name) }

  # Methods
  def subtotal(date = Date.today)
    return nil if date.future?
    return nil if self.item.item_prices.for_date(date).empty?
    return self.item.retail_price_on_date(date) * self.quantity

    # return nil if date.nil? && self.item.current_retail_price.nil?
    # if !date.nil?
    #   return nil if date.future?
    #   check_date = self.item.item_prices.for_date(date)
    #   return nil if check_date.empty?
    #   return (self.item.retail_price_on_date(date) * self.quantity)
    # else
    #   # if no date is passed, then the current date is used.
    #   price = (self.item.current_retail_price * self.quantity)
    #   return price
    # end  
    
  end

end