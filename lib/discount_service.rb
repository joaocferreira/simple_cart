# frozen_string_literal: true

# handles discounts
class DiscountService
  attr_reader :rules

  def initialize(rules)
    @rules = rules
  end

  def discount_for(product_code:, quantity:)
    return 0 unless rules[product_code]

    rules[product_code].call(quantity)
  end
end
