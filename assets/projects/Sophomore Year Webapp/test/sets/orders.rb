module Contexts
  module Orders
    # Context for orders (assumes customer, user, address context)
    def create_orders
      @alexe_o1   = FactoryBot.create(:order, customer: @alexe, address: @alexe_a2, products_total: 5.25, tax: 0.37, shipping: 5.00, date: 5.days.ago.to_date)
      @alexe_o1.pay
      @alexe_o2   = FactoryBot.create(:order, customer: @alexe, address: @alexe_a2, products_total: 8.50, tax: 0.60, shipping: 5.00, date: 3.days.ago.to_date)
      @alexe_o2.pay
      @alexe_o3   = FactoryBot.create(:order, customer: @alexe, address: @alexe_a1, products_total: 20.05, tax: 1.40, shipping: 5.00, payment_receipt: nil, date: Date.current)
      @melanie_o1 = FactoryBot.create(:order, customer: @melanie, address: @melanie_a1, products_total: 3.95, tax: 0.28, shipping: 5.00, date: 4.days.ago.to_date)
      @melanie_o1.pay
      @melanie_o2 = FactoryBot.create(:order, customer: @melanie, address: @melanie_a1, products_total: 5.25, tax: 0.37, shipping: 5.00, payment_receipt: nil, date: Date.current)
      @anthony_o1 = FactoryBot.create(:order, customer: @anthony, address: @anthony_a1, products_total: 19.25, tax: 1.35, shipping: 5.00, date: Date.current)
      @anthony_o1.pay
      @ryan_o1    = FactoryBot.create(:order, customer: @ryan, address: @ryan_a1, products_total: 11.50, tax: 0.81, shipping: 5.00, payment_receipt: nil, date: Date.current)
    end
    
    def destroy_orders
      @alexe_o1.delete 
      @alexe_o2.delete
      @alexe_o3.delete
      @melanie_o1.delete
      @melanie_o2.delete
      @anthony_o1.delete
      @ryan_o1.delete
    end

  end
end