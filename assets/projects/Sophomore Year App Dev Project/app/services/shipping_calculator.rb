class ShippingCalculator
  def initialize(order)
    @order = order
    @order_items = order.order_items
  end

  attr_reader :order, :order_items

  def calculate_costs
    weight = 0
    return weight if order_items.empty?  # i.e., zero if cart empty...
    order_items.each do |order_item|
      weight += order_item.quantity * order_item.item.weight
    end
    calculate_shipping_costs(weight)
  end

  private
  def calculate_shipping_costs(weight, base=5.00)
    increment = calculate_shipping_increase(weight)
    cost = base + increment
  end

  def calculate_shipping_increase(total_weight, allowed=5, charge=0.25)
    return 0 if total_weight <= allowed
    extra = (total_weight - allowed).to_i
    increment = extra * charge
  end  
end
