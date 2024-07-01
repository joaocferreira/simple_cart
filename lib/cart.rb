# frozen_string_literal: true

# cart
class Cart
  attr_reader :currency

  def initialize(
    currency: nil
  )
    @currency = currency || '€'
  end

  def total_price
    "#{format('%.2f', subtotal)}#{currency}"
  end

  private

  def subtotal
    BigDecimal(0)
  end
end
