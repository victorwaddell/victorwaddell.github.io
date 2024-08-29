class User < ApplicationRecord
    include AppHelpers::Deletions
    include AppHelpers::Activeable::InstanceMethods
    extend AppHelpers::Activeable::ClassMethods

    # I already manually changed user the day it was released in an attempt to stay ahead of phase 3
    # Do i need to add testing for admin and shipper as currently, the customer test file has create_customer_users, but not the rest

    # Use built-in rails support for password protection
    has_secure_password
    
    # Callbacks
    before_destroy do 
        cannot_destroy_object()
    end

    # Relationships
    has_one :customer

    # Validations
    validates :username, presence: true, uniqueness: { case_sensitive: false }
    validates_presence_of :password, :on => :create 
    validates_presence_of :password_confirmation, :on => :create 
    validates_confirmation_of :password, message: "does not match"
    validates_length_of :password, :minimum => 4, message: "must be at least 4 characters long"
    validates_inclusion_of :role, in: %w( admin shipper customer ), message: "is not recognized in the system"

    # Scopes
    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) }
    scope :alphabetical, -> { order(:username) }
    scope :by_role, -> { order(:role) }
    scope :employees, -> { where.not(role: :customer) } # IS THERE A BETTER WAY?

    # Methods
    def make_active #flips an active boolean from inactive to active and updates the record in the database
        self.update!(active: true)
      end
  
    def make_inactive #flips an active boolean from active to inactive and updates the record
        self.update!(active: false)
    end

    # for use in authorizing with CanCan
    ROLES = [['Admin', :admin],['Shipper', :shipper],['Customer', :customer]]

    def role?(authorized_role)
        return false if role.nil?
        role.downcase.to_sym == authorized_role
    end

end