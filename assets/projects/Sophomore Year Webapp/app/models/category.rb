class Category < ApplicationRecord
    include AppHelpers::Deletions

    # Callbacks
    before_destroy do 
        cannot_destroy_object()
    end

    # Relationships
    has_many :items
    has_many :item_prices, through: :items

    # Validations
    validates :name, presence: true, uniqueness: { case_sensitive: false }

    # Scopes
    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) }
    scope :alphabetical, -> { order(:name) }

    # Methods 
    def make_active #flips an active boolean from inactive to active and updates the record in the database
        self.update!(active: true)
    end
  
    def make_inactive #flips an active boolean from active to inactive and updates the record
        self.update!(active: false)
    end


end