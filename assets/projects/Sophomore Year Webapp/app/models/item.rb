class Item < ApplicationRecord
  include AppHelpers::Deletions
  include AppHelpers::Validations

  # Callbacks
  before_destroy do 
    check_if_ever_in_order
    if errors.present?
      @destroyable = false
      throw(:abort)
    end
  end
  
  # Relationships
  belongs_to :category
  has_many :item_prices
  has_many :order_items
  has_many :orders, through: :order_items
  
  # Validations
  validates_numericality_of :weight, greater_than: 0
  validates_numericality_of :inventory_level, :only_integer => true, greater_than_or_equal_to: 0
  validates_numericality_of :reorder_level, :only_integer => true, greater_than_or_equal_to: 0
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validate -> { is_active_in_system(:category) }, on: :create
  
  # Scopes
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :alphabetical, -> { order(:name) }
  scope :featured, -> { where(is_featured: true) }
  scope :to_reorder, -> { where('items.inventory_level <= items.reorder_level') }
  scope :for_category, ->(category_id) { where(category_id: category_id) }
  
  # Methods
  def make_active #flips an active boolean from inactive to active and updates the record in the database
    self.update!(active: true)
  end
  
  def make_inactive #flips an active boolean from active to inactive and updates the record
    self.update!(active: false)
  end
  
  def current_retail_price
    # which returns the current retail price of an item or returns nil if a price has not yet been set
    curr_price_of_item = self.item_prices.current 
    return nil if curr_price_of_item.empty?
    curr_price_of_item.first.price  
  end
  
  def retail_price_on_date(date)
    # which returns the retail price of an item for a given date or returns nil if a price has not yet been set (parameter: date)
    # Using item prices scope to retrieve data for a date
    price_of_item_on_date = self.item_prices.for_date(date)  
    return nil if price_of_item_on_date.empty?
    price_of_item_on_date.first.price
  end

  private
  def check_if_ever_in_order
    unless no_orders?
      errors.add(:base, "Item cannot be deleted because previously placed in an order")
    end
  end
  
  def no_orders?
    self.orders.empty?
  end

  end
  