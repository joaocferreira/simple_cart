# frozen_string_literal: true

# cart
class Cart
  attr_reader :currency, :basket

  def initialize(
    currency: nil,
    products_repo: nil,
    discount_service: nil
  )
    @currency = currency || '€'
    @products_repo = products_repo
    @discount_service = discount_service
    @basket = []
  end

  def add(product_code, quantity = 1)
    product = products_repo.find_by_code(product_code)
    quantity.times { basket << { code: product.product_code, price: product.price } }
    self
  end

  def total_price
    total = subtotal - discount
    "#{format('%.2f', total)}#{currency}"
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

  def discount
    reduced_basket = basket.inject({}) do |acc, item|
      acc.tap do |a|
        a[item[:code]] ||= 0
        a[item[:code]] += 1
      end
    end
    reduced_basket.inject(0) do |sum, item|
      sum + discount_service.discount_for(product_code: item[0], quantity: item[1])
    end
  end

  def discount_service
    @discount_service ||= DiscountService.new({
                                                'GR1' => ->(n) { (n / 2) * BigDecimal('3.11') },
                                                'SR1' => lambda { |n|
                                                           n < 3 ? 0 : (BigDecimal('5.00') - BigDecimal('4.50')) * n
                                                         },
                                                'CF1' => ->(n) { n < 3 ? 0 : BigDecimal('11.23') * n * (1.to_f / 3) }
                                              })
  end
end
