# frozen_string_literal: true

# cart
class Cart
  attr_reader :currency, :basket

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
    quantity.times { basket << { code: product.product_code, price: product.price } }
    self
  end

  def total_price
    "#{format('%.2f', subtotal)}#{currency}"
  end

  def products_repo
    @products_repo ||= ProductRepo.new([
                                         Product.new('GR1', 'Green Tea', 3.11),
                                         Product.new('SR1', 'Strawberries', 5.00),
                                         Product.new('CF1', 'Coffee', 11.23)
                                       ])
  end

  private

  def subtotal
    basket.inject(0) { |acc, item| acc + item[:price] }
  end
end
