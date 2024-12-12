# Define custom rules for discounts.
module Rules
  def self.bogo_rule
    lambda do |quantity, price, base_price|
      # Buy one get one free
      free_items = quantity / 2
      price -= free_items * base_price
      price
    end
  end

  def self.three_or_more_bulk_discount_rule(discount_price)
    lambda do |quantity, price, base_price|
      # Bulk discount for three or more items
      price = quantity * discount_price if quantity >= 3
      price
    end
  end

  def self.bulk_discount_percentage_rule(percentage)
    lambda do |quantity, price, base_price|
      # Percentage discount for bulk purchases
      price = quantity * (base_price * percentage) if quantity >= 3
      price
    end
  end
end
