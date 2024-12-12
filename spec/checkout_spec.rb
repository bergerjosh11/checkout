# Unit tests for the checkout system.
require_relative "../checkout_system"
require_relative "../pricing_rules"
require_relative "../rules"
require "rspec"
require "csv"

RSpec.describe Checkout do
  let(:price_file_path) { "prices.csv" }
  let(:pricing_rules) { PricingRules.new(price_file_path) }

  let(:checkout) { Checkout.new(pricing_rules) }

  it "calculates the total price correctly for test case 1" do
    %w[GR1 SR1 GR1 GR1 CF1].each { |item| checkout.scan(item) }
    puts "Total for test case 1: #{checkout.total}; expected: 22.45"
    expect(checkout.total).to eq(22.45)
  end

  it "calculates the total price correctly for test case 2" do
    %w[GR1 GR1].each { |item| checkout.scan(item) }
    puts "Total for test case 2: #{checkout.total}; expected: 3.11"
    expect(checkout.total).to eq(3.11)
  end

  it "calculates the total price correctly for test case 3" do
    %w[SR1 SR1 GR1 SR1].each { |item| checkout.scan(item) }
    puts "Total for test case 3: #{checkout.total}; expected: 16.61"
    expect(checkout.total).to eq(16.61)
  end

  it "calculates the total price correctly for test case 4" do
    %w[GR1 CF1 SR1 CF1 CF1].each { |item| checkout.scan(item) }
    puts "Total for test case 4: #{checkout.total}; expected: 30.57"
    expect(checkout.total).to eq(30.57)
  end

  it "raises an error for items without a price" do
    checkout.scan("UNKNOWN")
    expect { checkout.total }.to raise_error("No price defined for item: UNKNOWN")
  end
end

# prices.csv
# Sample CSV content for product prices
# ProductCode,Price,DiscountPrice,DiscountPercentage,Rules
# GR1,3.11,,,bogo_rule
# SR1,5.00,4.50,,three_or_more_bulk_discount_rule
# CF1,11.23,,0.6667,bulk_discount_percentage_rule

# Run the tests
# RSpec::Core::Runner.run(["spec/checkout_spec.rb"])
