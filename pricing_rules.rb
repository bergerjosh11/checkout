# Defines the pricing rules for applying discount rules.
require 'csv'

class PricingRules
  def initialize(price_file_path)
    @rules = {}
    @product_rules = {}
    @price_file_path = price_file_path
    @item_prices = load_prices
  end

  # Add a pricing rule for a specific product.
  def add_rule(product_code, &rule)
    @rules[product_code] ||= []
    @rules[product_code] << rule
  end

  # Add rules to a product (for more complex associations).
  def assign_rules_to_product(product_code, rule_names)
    @product_rules[product_code] ||= []
    @product_rules[product_code].concat(rule_names)
  end

  # Apply all rules to calculate the price for a specific item and quantity.
  def apply(item, quantity)
    base_price = @item_prices[item]

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

  # Load prices from a CSV file.
  def load_prices
    prices = {}
    CSV.foreach(@price_file_path, headers: true) do |row|
      prices[row["ProductCode"]] = row["Price"].to_f
    end
    prices
  end
end
