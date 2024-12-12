# Unit tests for the checkout system.
require_relative "../checkout_system"
require_relative "../pricing_rules"
require_relative "../rules"
require "rspec"
require "csv"

RSpec.describe Checkout do
  let(:price_file_path) { "prices.csv" }
  let(:pricing_rules) { PricingRules.new(price_file_path) }

  before do
    pricing_rules.add_rule("GR1", &Rules.bogo_rule)
    pricing_rules.add_rule("SR1", &Rules.three_or_more_bulk_discount_rule(4.50))
    pricing_rules.add_rule("CF1", &Rules.bulk_discount_percentage_rule(2.0 / 3.0))
  end

  let(:checkout) { Checkout.new(pricing_rules) }

  it "calculates the total price correctly for test case 1" do
    %w[GR1 SR1 GR1 GR1 CF1].each { |item| checkout.scan(item) }
    expect(checkout.total).to eq(22.45)
  end

  it "calculates the total price correctly for test case 2" do
    %w[GR1 GR1].each { |item| checkout.scan(item) }
    expect(checkout.total).to eq(3.11)
  end

  it "calculates the total price correctly for test case 3" do
    %w[SR1 SR1 GR1 SR1].each { |item| checkout.scan(item) }
    expect(checkout.total).to eq(16.61)
  end

  it "calculates the total price correctly for test case 4" do
    %w[GR1 CF1 SR1 CF1 CF1].each { |item| checkout.scan(item) }
    expect(checkout.total).to eq(30.57)
  end

  it "raises an error for items without a price" do
    checkout.scan("UNKNOWN")
    expect { checkout.total }.to raise_error("No price defined for item: UNKNOWN")
  end
end
