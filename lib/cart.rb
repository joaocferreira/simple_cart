# frozen_string_literal: true

# cart
class Cart
  attr_reader :currency, :products_repo, :basket

  def initialize(
    currency: nil,
    products_repo: nil
  )
    @currency = currency || '€'
    @products_repo = products_repo
    @basket = []
  end

  def add(product_code, quantity = 1)
    product = products_repo.find_by_code(product_code)
    quantity.times { basket << { code: product.code, price: product.price } }
    self
  end

  def total_price
    "#{format('%.2f', subtotal)}#{currency}"
  end

  private

  def subtotal
    basket.inject(0) { |acc, item| acc + item[:price] }
  end
end
