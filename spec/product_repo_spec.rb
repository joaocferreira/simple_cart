# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

RSpec.describe ProductRepo do
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

  let(:subject) do
    described_class.new([product_a, product_b])
  end

  it 'contains expected products' do
    expect(subject.all_products).to match_array([product_a, product_b])
  end

  describe '#find_by_code' do
    context 'when product does not exist' do
      it 'returns nil' do
        expect(subject.find_by_code('FOO')).to be_nil
      end
    end
    context 'when product exists' do
      it 'returns expected product' do
        expect(subject.find_by_code('PB')).to eq(product_b)
        expect(subject.find_by_code('PA')).to eq(product_a)
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
