class ItemPrice < ApplicationRecord
  include AppHelpers::Deletions
  include AppHelpers::Validations

  # Callbacks
  before_create do
    set_current_item_price_end_date()
    set_new_item_price_start_date()
  end
  before_destroy do 
    cannot_destroy_object()
  end

  # Relationships
  belongs_to :item

  # Validations
  validates_numericality_of :price, greater_than_or_equal_to: 0
  validate -> { is_active_in_system(:item) }, on: :create

  # Scopes
  scope :current,       -> { where("end_date IS NULL") }
  scope :chronological, -> { order(start_date: :desc) }
  scope :for_item,  ->(item_id) { where(item_id: item_id) }
  scope :for_date,  ->(date) { where("start_date <= ? AND (end_date > ? OR end_date IS NULL)", date, date) }
  
  # Methods

  private
  #Before a new item price is created, the current end_date price for that item must be set for today
  def set_current_item_price_end_date
    previous = ItemPrice.current.for_item(self.item_id).take
    previous.update_attribute(:end_date, Date.current) unless previous.nil?
  end

  #When a new item price is created, the price start_date must be set for the next day
  def set_new_item_price_start_date
    self.start_date = Date.tomorrow
  end
  


end