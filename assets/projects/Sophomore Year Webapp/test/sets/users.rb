module Contexts
  module Users
    # Context for users
    def create_customer_users
      @u_alexe   = FactoryBot.create(:user, username: "alexe", greeting: "Alex")
      @u_melanie = FactoryBot.create(:user, username: "melanie", greeting: "Melanie")
      @u_anthony = FactoryBot.create(:user, username: "anthony", greeting: "Anthony")
      @u_ryan    = FactoryBot.create(:user, username: "ryan", greeting: "Ryan")
      @u_sherry  = FactoryBot.create(:user, username: "sherry", active: false, greeting: "Sherry")
    end
    
    def destroy_customer_users
      @u_alexe.delete
      @u_melanie.delete
      @u_anthony.delete
      @u_ryan.delete 
      @u_sherry.delete
    end

    def create_employee_users
      @alex        = FactoryBot.create(:user, username: "tank", role: "admin", greeting: "Alex")
      @mark        = FactoryBot.create(:user, username: "mark", role: "admin", greeting: "Mark")
      @shipper     = FactoryBot.create(:user, username: "shipper", role: "shipper", greeting: "Sam")
      @old_shipper = FactoryBot.create(:user, username: "old_shipper", role: "shipper", active: false, greeting: "Simon")
    end

    def destroy_employee_users
      @alex.delete
      @mark.delete
      @shipper.delete
      @old_shipper.delete
    end

  end
end