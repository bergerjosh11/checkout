# Defines the pricing rules for applying discount rules.
class PricingRules
  def initialize
    @rules = []
  end

  # Add a pricing rule.
  def add_rule(&rule)
    @rules << rule
  end

  # Apply all rules to calculate the price for a specific item and quantity.
  def apply(item, quantity)
    base_price = item_prices[item]

    # If the item has no price, raise an error
    unless base_price
      raise "No price defined for item: #{item}"
    end

    price = base_price * quantity

    @rules.each do |rule|
      price = rule.call(item, quantity, price)
    end

    price
  end

  private

  # Define the base prices for each product.
  def item_prices
    {
      "GR1" => 3.11,
      "SR1" => 5.00,
      "CF1" => 11.23
    }
  end
end
