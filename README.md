# Checkout System

The Checkout System is a modular and extensible Ruby application that provides a simple, rule-driven system for scanning products and calculating their total price. With a strong emphasis on flexibility, the system allows for seamless customization of pricing rules and product configurations.

---

## Table of Contents

1. [Features](#features)
2. [System Requirements](#system-requirements)
3. [Installation](#installation)
4. [Usage](#usage)
5. [File Descriptions](#file-descriptions)
6. [Pricing Rules](#pricing-rules)
7. [Modularity and Extensibility](#modularity-and-extensibility)
8. [Testing](#testing)

---

## Features

- **Modular Design**: Clear separation of concerns with dedicated classes for checkout, pricing rules, and discount rules.
- **Scan Items**: Add products to the cart by scanning their product codes.
- **Pricing Rules**: Support for various discount rules, including:
  - **Buy One Get One Free (BOGO)**
  - **Bulk Pricing (e.g., 3 or more)**
  - **Percentage-based discounts**
- **CSV-based Pricing**: Load product prices and rules from a CSV file for easy customization.
- **Unit Tests**: RSpec tests to ensure system accuracy.

---

## System Requirements

- **Ruby**: Version 2.7 or higher is recommended.
- **Bundler**: To manage Ruby gems.

---

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/bergerjosh11/checkout.git
   cd checkout
   ```
2. Install dependencies:
   ```bash
   bundle install
   ```
3. Ensure you have the required CSV file for prices.

---

## Usage

1. Start a new checkout session:
   ```ruby
   pricing_rules = PricingRules.new('path/to/prices.csv')
   checkout = Checkout.new(pricing_rules)
   ```
2. Scan items using their product codes:
   ```ruby
   checkout.scan('GR1')
   checkout.scan('SR1')
   checkout.scan('CF1')
   ```
3. Calculate the total price:
   ```ruby
   total_price = checkout.total
   puts "Total price: \#{total_price}"
   ```

---

## File Descriptions

- **`checkout_system.rb`**: Main file that defines the `Checkout` class for scanning items and calculating the total price.
- **`pricing_rules.rb`**: Contains logic for applying rules to determine the final price for each item.
- **`rules.rb`**: Defines reusable discount rules (like BOGO, bulk discount, and percentage discount).
- **`spec/checkout_spec.rb`**: RSpec tests for validating the correctness of the checkout system.
- **`prices.csv`**: CSV file containing product codes, prices, and discount rules for products.

---

## Pricing Rules

### 1. **Buy One Get One Free (BOGO)**
- **Rule Name**: `bogo_rule`
- **Logic**: Every second item is free.
- **Example**: For 4 GR1s at $3.11 each, the price is $6.22 (2 items charged, 2 items free).

### 2. **Bulk Pricing Rule**
- **Rule Name**: `three_or_more_bulk_discount_rule`
- **Logic**: If 3 or more of the same item are purchased, the price per item drops to a discounted rate.
- **Example**: For 3 SR1s at $5.00 each, if the bulk price is $4.50, the total price is $13.50.

### 3. **Bulk Discount Percentage**
- **Rule Name**: `bulk_discount_percentage_rule`
- **Logic**: If 3 or more of the same item are purchased, apply a percentage discount.
- **Example**: If the original price for CF1 is $11.23, and the discount is 33.33%, the new price is calculated as:
  ```
  new_price = 11.23 * (1 - 0.3333)
  ```

---

## Modularity and Extensibility

The Checkout System's modular design allows for easy customization and scalability. Here are some key design principles:

- **Separation of Concerns**: The system is divided into self-contained classes for checkout, pricing logic, and rules. Each class handles a specific responsibility, making it easier to maintain and extend.
- **Rule Customization**: New discount rules can be added by defining them in the `rules.rb` file and referencing them in the CSV file. This enables business-specific logic to be added without changing the core application.
- **Data-Driven Pricing**: Product pricing and discount logic are stored in a CSV file, making it simple to update prices and rules without modifying the application code.
- **Extensible Design**: The `PricingRules` and `Rules` classes make it easy to add new rule types, allowing for future scalability.

---

## Testing

This project uses **RSpec** to validate system functionality.

### Run tests
```bash
rspec spec/checkout_spec.rb --format documentation
```

### Example Output
```
Total for test case 1: 22.45; expected: 22.45
Total for test case 2: 3.11; expected: 3.11
Total for test case 3: 16.61; expected: 16.61
Total for test case 4: 30.57; expected: 30.57

Finished in 0.03068 seconds (files took 0.21639 seconds to load)
5 examples, 0 failures
```

---

## Sample CSV (prices.csv)
```
ProductCode,Price,DiscountPrice,DiscountPercentage,Rules
GR1,3.11,,,bogo_rule
SR1,5.00,4.50,,three_or_more_bulk_discount_rule
CF1,11.23,,0.3333,bulk_discount_percentage_rule
```

---

If you have any questions or suggestions for improvement, please feel free to submit an issue or pull request on GitHub.

