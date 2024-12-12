# Defines the pricing rules for applying discount rules.
require 'csv'

class PricingRules
  def initialize(price_file_path)
    @rules = {}
    @price_file_path = price_file_path
    @item_prices = load_prices
  end

  # Apply all rules to calculate the price for a specific item and quantity.
  def apply(item, quantity)
    product_data = @item_prices[item]
    
    unless product_data
      raise "No price defined for item: #{item}"
    end

    base_price = product_data[:price]
    price = base_price * quantity

    if product_data[:rules]
      product_data[:rules].each do |rule|
        price = Rules.get_rule(rule).call(quantity, price, base_price, product_data)
      end
    end

    price
  end

  private

  # Load prices from a CSV file, including rules, discount prices, and discount percentages.
  def load_prices
    prices = {}
    CSV.foreach(@price_file_path, headers: true) do |row|
      product_code = row["ProductCode"]
      prices[product_code] = {
        price: row["Price"].to_f,
        discount_price: row["DiscountPrice"] ? row["DiscountPrice"].to_f : nil,
        discount_percentage: row["DiscountPercentage"] ? row["DiscountPercentage"].to_f : nil,
        rules: row["Rules"] ? row["Rules"].split(',').map(&:strip) : []
      }
    end
    prices
  end
end
