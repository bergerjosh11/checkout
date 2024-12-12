# Defines the pricing rules for applying discount rules.
class PricingRules
  def initialize
    @rules = {}
  end

  # Add a pricing rule for a specific product.
  def add_rule(product_code, &rule)
    @rules[product_code] ||= []
    @rules[product_code] << rule
  end

  # Apply all rules to calculate the price for a specific item and quantity.
  def apply(item, quantity)
    base_price = item_prices[item]

    # If the item has no price, raise an error
    unless base_price
      raise "No price defined for item: #{item}"
    end

    price = base_price * quantity

    # Apply rules specific to the item, if any
    if @rules[item]
      @rules[item].each do |rule|
        price = rule.call(quantity, price)
      end
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
