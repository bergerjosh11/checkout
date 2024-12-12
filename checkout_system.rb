# Handles scanning items and calculating total price.
class Checkout
  attr_reader :pricing_rules, :cart

  # Initialize Checkout with pricing rules.
  def initialize(pricing_rules)
    @pricing_rules = pricing_rules
    @cart = []
  end

  # Add an item to the cart.
  def scan(item)
    @cart << item
  end

  # Calculate the total price, applying pricing rules.
  def total
    total_price = 0

    # Group items by product code for rule application.
    grouped_items = @cart.tally

    grouped_items.each do |item, quantity|
      total_price += @pricing_rules.apply(item, quantity)
    end

    total_price.round(2)
  end
end
