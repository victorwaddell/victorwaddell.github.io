class Item < ApplicationRecord
  # Modules to help with some functionality
  include AppHelpers::Validations
  include AppHelpers::Activeable::InstanceMethods
  extend AppHelpers::Activeable::ClassMethods
  
  # Relationships
  belongs_to :category
  has_many :item_prices
  has_many :order_items
  has_many :orders, through: :order_items

  # Scopes
  scope :alphabetical, -> { order(:name) }
  scope :featured,     -> { where(is_featured: true) }
  scope :for_category, ->(category) { where(category_id: category.id) }
  scope :to_reorder,   -> { where('items.reorder_level >= items.inventory_level') }
  scope :search,       ->(term) { where('name LIKE ? OR description LIKE ?', "%#{term}%", "%#{term}%") }


  # Validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates_numericality_of :inventory_level, only_integer: true, greater_than_or_equal_to: 0
  validates_numericality_of :reorder_level, only_integer: true, greater_than_or_equal_to: 0
  validates_numericality_of :weight, greater_than: 0
  validate :category_is_active_in_the_system, on: :create

  # Other methods
  def current_retail_price
    curr = self.item_prices.current.first
    if curr.nil?
      return nil
    else
      return curr.price
    end
  end

  def retail_price_on_date(date)
    data = self.item_prices.for_date(date).first
    if data.nil?
      return nil
    else
      return data.price
    end
  end

  # Callbacks
  before_destroy do
    check_if_item_part_of_any_order
    if errors.present?
      @destroyable = false
      throw(:abort)
    end
  end

  private
  def category_is_active_in_the_system
    is_active_in_system(:category)
  end

  def check_if_item_part_of_any_order
    unless self.order_items.empty?
      errors.add(:base, "This item has already been part of an order and therefore cannot be deleted.")
    end
  end

end
