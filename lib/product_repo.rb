# frozen_string_literal: true

# in memory product_repo
class ProductRepo
  def initialize(products)
    @products = products
  end

  def find_by_code(code)
    products.find { |product| product.product_code == code }
  end

  def all_products
    products.dup
  end

  private

  attr_reader :products
end
