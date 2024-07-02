# frozen_string_literal: true

# product dto
class Product
  attr_reader :product_code, :name, :price

  def initialize(product_code, name, price)
    @product_code = product_code
    @name = name
    @price = price
  end
end
