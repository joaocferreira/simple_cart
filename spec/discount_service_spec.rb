# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

RSpec.describe DiscountService do
  let(:product_a) do
    instance_double(
      Product,
      product_code: 'PA',
      price: BigDecimal('6.03')
    )
  end
  let(:product_b) do
    instance_double(
      Product,
      product_code: 'PB',
      price: BigDecimal('5.01')
    )
  end
  subject do
    described_class.new({
                          product_a.product_code => ->(n) { (n / 2) * product_a.price },
                          product_b.product_code => lambda do |n|
                                                      n < 4 ? 0 : (product_b.price - BigDecimal('4.50')) * n
                                                    end
                        })
  end

  describe '#discount_for' do
    context 'when no discount' do
      it 'returns 0' do
        expect(subject.discount_for(product_code: 'PA', quantity: 1)).to eq(0)
        expect(subject.discount_for(product_code: 'PB', quantity: 3)).to eq(0)
      end
    end

    context 'when discount' do
      it 'returns expected discount' do
        expect(subject.discount_for(product_code: 'PA', quantity: 2)).to eq(6.03)
        expect(subject.discount_for(product_code: 'PA', quantity: 3)).to eq(6.03)
        expect(subject.discount_for(product_code: 'PA', quantity: 4)).to eq(12.06)

        expect(subject.discount_for(product_code: 'PB', quantity: 4)).to eq(2.04)
        expect(subject.discount_for(product_code: 'PB', quantity: 5)).to eq(2.55)
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
