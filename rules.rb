# Define custom rules for discounts.
module Rules
  def self.bogo_rule
    lambda do |quantity, price|
      # Buy one get one free
      free_items = quantity / 2
      price -= free_items * 3.11
      price
    end
  end

  def self.three_or_more_bulk_discount_rule(discount_price)
    lambda do |quantity, price|
      # Bulk discount for three or more items
      price = quantity * discount_price if quantity >= 3
      price
    end
  end

  def self.bulk_discount_percentage_rule(percentage)
    lambda do |quantity, price|
      # Percentage discount for bulk purchases
      price = quantity * (11.23 * percentage) if quantity >= 3
      price
    end
  end
end
