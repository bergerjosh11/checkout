# Define custom rules for discounts.
module Rules
  RULES = {
    'bogo_rule' => lambda do |quantity, price, base_price, product_data|
      # Buy one get one free
      free_items = quantity / 2
      price -= free_items * base_price
      price
    end,

    'three_or_more_bulk_discount_rule' => lambda do |quantity, price, base_price, product_data|
      # Bulk discount for three or more items
      discount_price = product_data[:discount_price]
      if quantity >= 3 && discount_price
        price = quantity * discount_price
      end
      price
    end,

    'bulk_discount_percentage_rule' => lambda do |quantity, price, base_price, product_data|
      # Percentage discount for bulk purchases
      discount_percentage = product_data[:discount_percentage]
      if quantity >= 3 && discount_percentage
        price = (quantity * (base_price * discount_percentage)).round(2)
      end
      price
    end
  }

  def self.get_rule(rule_name)
    RULES[rule_name]
  end
end
